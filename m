Return-Path: <SRS0=n+Ub=5Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9DEFC2BB55
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Apr 2020 13:20:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 876AE20857
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Apr 2020 13:20:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726817AbgDINUm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Apr 2020 09:20:42 -0400
Received: from ivanoab7.miniserver.com ([37.128.132.42]:41048 "EHLO
        www.kot-begemot.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726621AbgDINUl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Apr 2020 09:20:41 -0400
Received: from tun252.jain.kot-begemot.co.uk ([192.168.18.6] helo=jain.kot-begemot.co.uk)
        by www.kot-begemot.co.uk with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <anton.ivanov@cambridgegreys.com>)
        id 1jMX6k-0006Uc-Ha; Thu, 09 Apr 2020 13:20:38 +0000
Received: from jain.kot-begemot.co.uk ([192.168.3.3])
        by jain.kot-begemot.co.uk with esmtp (Exim 4.92)
        (envelope-from <anton.ivanov@cambridgegreys.com>)
        id 1jMX6i-00080H-5Q; Thu, 09 Apr 2020 14:20:38 +0100
Subject: Re: [PATCH] um: add a generic "fd" vector transport
To:     =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
        linux-um@lists.infradead.org
Cc:     joerd.simons@collabora.co.uk, richard@nod.at, jdike@addtoit.com,
        linux-kernel@vger.kernel.org, alex.dewar@gmx.co.uk
References: <20200407202853.1791218-1-marcandre.lureau@redhat.com>
From:   Anton Ivanov <anton.ivanov@cambridgegreys.com>
Message-ID: <b21237a4-e54e-8d3d-fba2-c95d76b434bb@cambridgegreys.com>
Date:   Thu, 9 Apr 2020 14:20:36 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200407202853.1791218-1-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Clacks-Overhead: GNU Terry Pratchett
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 07/04/2020 21:28, Marc-André Lureau wrote:
> Learn to take a pre-opened file-descriptor for vector IO.
>
> Instead of teaching the driver to open a FD in multiple ways, it can
> rely on management layer to do it on its behalf. For example, this
> allows inheriting a preconfigured device fd or a simple socketpair()
> setup, without further arguments, privileges or system access by UML.
>
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> ---
>   arch/um/drivers/vector_user.c | 59 +++++++++++++++++++++++++++++++++++
>   1 file changed, 59 insertions(+)
>
> diff --git a/arch/um/drivers/vector_user.c b/arch/um/drivers/vector_user.c
> index 29fae0456ade..45c1550dbb37 100644
> --- a/arch/um/drivers/vector_user.c
> +++ b/arch/um/drivers/vector_user.c
> @@ -29,6 +29,7 @@
>   #include <netdb.h>
>   #include <stdlib.h>
>   #include <os.h>
> +#include <limits.h>
>   #include <um_malloc.h>
>   #include "vector_user.h"
>   
> @@ -42,6 +43,9 @@
>   #define TRANS_RAW "raw"
>   #define TRANS_RAW_LEN strlen(TRANS_RAW)
>   
> +#define TRANS_FD "fd"
> +#define TRANS_FD_LEN strlen(TRANS_FD)
> +
>   #define VNET_HDR_FAIL "could not enable vnet headers on fd %d"
>   #define TUN_GET_F_FAIL "tapraw: TUNGETFEATURES failed: %s"
>   #define L2TPV3_BIND_FAIL "l2tpv3_open : could not bind socket err=%i"
> @@ -347,6 +351,59 @@ static struct vector_fds *user_init_unix_fds(struct arglist *ifspec, int id)
>   	return NULL;
>   }
>   
> +static int strtofd(const char *nptr)
> +{
> +	long fd;
> +	char *endptr;
> +
> +	if (nptr == NULL)
> +		return -1;
> +
> +	errno = 0;
> +	fd = strtol(nptr, &endptr, 10);
> +	if (nptr == endptr ||
> +		errno != 0 ||
> +		*endptr != '\0' ||
> +		fd < 0 ||
> +		fd > INT_MAX) {
> +		return -1;
> +	}
> +	return fd;
> +}
> +
> +static struct vector_fds *user_init_fd_fds(struct arglist *ifspec)
> +{
> +	int fd = -1;
> +	char *fdarg = NULL;
> +	struct vector_fds *result = NULL;
> +
> +	fdarg = uml_vector_fetch_arg(ifspec, "fd");
> +	fd = strtofd(fdarg);
> +	if (fd == -1) {
> +		printk(UM_KERN_ERR "fd open: bad or missing fd argument");
> +		goto fd_cleanup;
> +	}
> +
> +	result = uml_kmalloc(sizeof(struct vector_fds), UM_GFP_KERNEL);
> +	if (result == NULL) {
> +		printk(UM_KERN_ERR "fd open: allocation failed");
> +		goto fd_cleanup;
> +	}
> +
> +	result->rx_fd = fd;
> +	result->tx_fd = fd;
> +	result->remote_addr_size = 0;
> +	result->remote_addr = NULL;
> +	return result;
> +
> +fd_cleanup:
> +	if (fd >= 0)
> +		os_close_file(fd);
> +	if (result != NULL)
> +		kfree(result);
> +	return NULL;
> +}
> +
>   static struct vector_fds *user_init_raw_fds(struct arglist *ifspec)
>   {
>   	int rxfd = -1, txfd = -1;
> @@ -578,6 +635,8 @@ struct vector_fds *uml_vector_user_open(
>   		return user_init_socket_fds(parsed, ID_L2TPV3);
>   	if (strncmp(transport, TRANS_BESS, TRANS_BESS_LEN) == 0)
>   		return user_init_unix_fds(parsed, ID_BESS);
> +	if (strncmp(transport, TRANS_FD, TRANS_FD_LEN) == 0)
> +		return user_init_fd_fds(parsed);
>   	return NULL;
>   }
>   
Acked-By: Anton Ivanov <anton.ivanov@cambridgegreys.com>

-- 
Anton R. Ivanov
Cambridgegreys Limited. Registered in England. Company Number 10273661
https://www.cambridgegreys.com/

