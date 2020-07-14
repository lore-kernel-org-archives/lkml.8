Return-Path: <SRS0=dAmO=AZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2DCEC433E5
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 08:40:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BEB5221897
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 08:40:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726478AbgGNIkM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jul 2020 04:40:12 -0400
Received: from ivanoab7.miniserver.com ([37.128.132.42]:47474 "EHLO
        www.kot-begemot.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725816AbgGNIkL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jul 2020 04:40:11 -0400
Received: from tun252.jain.kot-begemot.co.uk ([192.168.18.6] helo=jain.kot-begemot.co.uk)
        by www.kot-begemot.co.uk with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <anton.ivanov@cambridgegreys.com>)
        id 1jvGTq-0001ZN-VU; Tue, 14 Jul 2020 08:40:04 +0000
Received: from jain.kot-begemot.co.uk ([192.168.3.3])
        by jain.kot-begemot.co.uk with esmtp (Exim 4.92)
        (envelope-from <anton.ivanov@cambridgegreys.com>)
        id 1jvGTo-0001s5-Jt; Tue, 14 Jul 2020 09:40:02 +0100
Subject: Re: [PATCH v2 2/3] um: some fixes to build UML with musl
To:     Ignat Korchagin <ignat@cloudflare.com>, jdike@addtoit.com,
        richard@nod.at, brendanhiggins@google.com,
        linux-um@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     kernel-team@cloudflare.com, johannes.berg@intel.com
References: <20200704085213.444645-1-ignat@cloudflare.com>
 <20200704085213.444645-3-ignat@cloudflare.com>
From:   Anton Ivanov <anton.ivanov@cambridgegreys.com>
Message-ID: <8b168d8c-f526-42b4-7cec-ec7c26c64122@cambridgegreys.com>
Date:   Tue, 14 Jul 2020 09:40:00 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200704085213.444645-3-ignat@cloudflare.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Clacks-Overhead: GNU Terry Pratchett
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 04/07/2020 09:52, Ignat Korchagin wrote:
> musl toolchain and headers are a bit more strict. These fixes enable building
> UML with musl as well as seem not to break on glibc.
> 
> Signed-off-by: Ignat Korchagin <ignat@cloudflare.com>
> ---
>   arch/um/drivers/daemon_user.c |  1 +
>   arch/um/drivers/pcap_user.c   | 12 ++++++------
>   arch/um/drivers/slip_user.c   |  2 +-
>   arch/um/drivers/vector_user.c |  4 +---
>   arch/um/os-Linux/util.c       |  2 +-
>   arch/x86/um/user-offsets.c    |  2 +-
>   6 files changed, 11 insertions(+), 12 deletions(-)
> 
> diff --git a/arch/um/drivers/daemon_user.c b/arch/um/drivers/daemon_user.c
> index 3695821d06a2..785baedc3555 100644
> --- a/arch/um/drivers/daemon_user.c
> +++ b/arch/um/drivers/daemon_user.c
> @@ -7,6 +7,7 @@
>    */
>   
>   #include <stdint.h>
> +#include <string.h>
>   #include <unistd.h>
>   #include <errno.h>
>   #include <sys/types.h>
> diff --git a/arch/um/drivers/pcap_user.c b/arch/um/drivers/pcap_user.c
> index bbd20638788a..52ddda3e3b10 100644
> --- a/arch/um/drivers/pcap_user.c
> +++ b/arch/um/drivers/pcap_user.c
> @@ -32,7 +32,7 @@ static int pcap_user_init(void *data, void *dev)
>   	return 0;
>   }
>   
> -static int pcap_open(void *data)
> +static int pcap_user_open(void *data)

This change in the function name was introduced on purpose to avoid name clash in some version of libpcap which export pcap_open


>   {
>   	struct pcap_data *pri = data;
>   	__u32 netmask;
> @@ -44,14 +44,14 @@ static int pcap_open(void *data)
>   	if (pri->filter != NULL) {
>   		err = dev_netmask(pri->dev, &netmask);
>   		if (err < 0) {
> -			printk(UM_KERN_ERR "pcap_open : dev_netmask failed\n");
> +			printk(UM_KERN_ERR "pcap_user_open : dev_netmask failed\n");
>   			return -EIO;
>   		}
>   
>   		pri->compiled = uml_kmalloc(sizeof(struct bpf_program),
>   					UM_GFP_KERNEL);
>   		if (pri->compiled == NULL) {
> -			printk(UM_KERN_ERR "pcap_open : kmalloc failed\n");
> +			printk(UM_KERN_ERR "pcap_user_open : kmalloc failed\n");
>   			return -ENOMEM;
>   		}
>   
> @@ -59,14 +59,14 @@ static int pcap_open(void *data)
>   				   (struct bpf_program *) pri->compiled,
>   				   pri->filter, pri->optimize, netmask);
>   		if (err < 0) {
> -			printk(UM_KERN_ERR "pcap_open : pcap_compile failed - "
> +			printk(UM_KERN_ERR "pcap_user_open : pcap_compile failed - "
>   			       "'%s'\n", pcap_geterr(pri->pcap));
>   			goto out;
>   		}
>   
>   		err = pcap_setfilter(pri->pcap, pri->compiled);
>   		if (err < 0) {
> -			printk(UM_KERN_ERR "pcap_open : pcap_setfilter "
> +			printk(UM_KERN_ERR "pcap_user_open : pcap_setfilter "
>   			       "failed - '%s'\n", pcap_geterr(pri->pcap));
>   			goto out;
>   		}
> @@ -127,7 +127,7 @@ int pcap_user_read(int fd, void *buffer, int len, struct pcap_data *pri)
>   
>   const struct net_user_info pcap_user_info = {
>   	.init		= pcap_user_init,
> -	.open		= pcap_open,
> +	.open		= pcap_user_open,
>   	.close	 	= NULL,
>   	.remove	 	= pcap_remove,
>   	.add_address	= NULL,
> diff --git a/arch/um/drivers/slip_user.c b/arch/um/drivers/slip_user.c
> index 8016d32b6809..482a19c5105c 100644
> --- a/arch/um/drivers/slip_user.c
> +++ b/arch/um/drivers/slip_user.c
> @@ -9,7 +9,7 @@
>   #include <errno.h>
>   #include <fcntl.h>
>   #include <string.h>
> -#include <sys/termios.h>
> +#include <termios.h>
>   #include <sys/wait.h>
>   #include <net_user.h>
>   #include <os.h>
> diff --git a/arch/um/drivers/vector_user.c b/arch/um/drivers/vector_user.c
> index c4a0f26b2824..45d4164ad355 100644
> --- a/arch/um/drivers/vector_user.c
> +++ b/arch/um/drivers/vector_user.c
> @@ -18,9 +18,7 @@
>   #include <fcntl.h>
>   #include <sys/socket.h>
>   #include <sys/un.h>
> -#include <net/ethernet.h>
>   #include <netinet/ip.h>
> -#include <netinet/ether.h>
>   #include <linux/if_ether.h>
>   #include <linux/if_packet.h>
>   #include <sys/wait.h>
> @@ -332,7 +330,7 @@ static struct vector_fds *user_init_unix_fds(struct arglist *ifspec, int id)
>   	}
>   	switch (id) {
>   	case ID_BESS:
> -		if (connect(fd, remote_addr, sizeof(struct sockaddr_un)) < 0) {
> +		if (connect(fd, (const struct sockaddr *) remote_addr, sizeof(struct sockaddr_un)) < 0) {
>   			printk(UM_KERN_ERR "bess open:cannot connect to %s %i", remote_addr->sun_path, -errno);
>   			goto unix_cleanup;
>   		}
> diff --git a/arch/um/os-Linux/util.c b/arch/um/os-Linux/util.c
> index ecf2f390fad2..07327425d06e 100644
> --- a/arch/um/os-Linux/util.c
> +++ b/arch/um/os-Linux/util.c
> @@ -10,7 +10,7 @@
>   #include <signal.h>
>   #include <string.h>
>   #include <termios.h>
> -#include <wait.h>
> +#include <sys/wait.h>
>   #include <sys/mman.h>
>   #include <sys/utsname.h>
>   #include <init.h>
> diff --git a/arch/x86/um/user-offsets.c b/arch/x86/um/user-offsets.c
> index c51dd8363d25..bae61554abcc 100644
> --- a/arch/x86/um/user-offsets.c
> +++ b/arch/x86/um/user-offsets.c
> @@ -2,7 +2,7 @@
>   #include <stdio.h>
>   #include <stddef.h>
>   #include <signal.h>
> -#include <sys/poll.h>
> +#include <poll.h>
>   #include <sys/mman.h>
>   #include <sys/user.h>
>   #define __FRAME_OFFSETS
> 

Apologies for the delay in answering, I was buried under OVS for the last month or so.

With the exception of this patch the rest of the series looks OK. Can you please resumbit and if Johannes and Richard are OK with it I will +1 it.

Best regards,

-- 
Anton R. Ivanov
Cambridgegreys Limited. Registered in England. Company Number 10273661
https://www.cambridgegreys.com/
