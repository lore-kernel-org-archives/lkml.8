Return-Path: <SRS0=BsgQ=65=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33376C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 07:01:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 14056206F1
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 07:01:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726622AbgEOHBR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 May 2020 03:01:17 -0400
Received: from mx2.suse.de ([195.135.220.15]:42320 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726295AbgEOHBP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 May 2020 03:01:15 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 33FC0ACFE;
        Fri, 15 May 2020 07:01:16 +0000 (UTC)
Subject: Re: [PATCH 1/1] xen/manage: enable C_A_D to force reboot
To:     Dongli Zhang <dongli.zhang@oracle.com>,
        xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org
Cc:     boris.ostrovsky@oracle.com, sstabellini@kernel.org,
        joe.jin@oracle.com, rose.wang@oracle.com
References: <20200513233410.18120-1-dongli.zhang@oracle.com>
From:   =?UTF-8?B?SsO8cmdlbiBHcm/Dnw==?= <jgross@suse.com>
Message-ID: <e604a96d-087e-573b-c3bf-fc53005f8994@suse.com>
Date:   Fri, 15 May 2020 09:01:12 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200513233410.18120-1-dongli.zhang@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14.05.20 01:34, Dongli Zhang wrote:
> The systemd may be configured to mask ctrl-alt-del via "systemctl mask
> ctrl-alt-del.target". As a result, the pv reboot would not work as signal
> is ignored.
> 
> This patch always enables C_A_D before the call of ctrl_alt_del() in order
> to force the reboot.

Hmm, I'm not sure this is a good idea.

Suppose a guest admin is doing a critical update and wants to avoid a
sudden reboot in between. By masking the reboot this would be possible,
with your patch it isn't.

In case a reboot is really mandatory it would still be possible to just
kill the guest.

I'm not completely opposed to the patch, but I think this is a change
which should not be done easily.


Juergen

> 
> Reported-by: Rose Wang <rose.wang@oracle.com>
> Cc: Joe Jin <joe.jin@oracle.com>
> Cc: Boris Ostrovsky <boris.ostrovsky@oracle.com>
> Signed-off-by: Dongli Zhang <dongli.zhang@oracle.com>
> ---
>   drivers/xen/manage.c | 7 +++++++
>   1 file changed, 7 insertions(+)
> 
> diff --git a/drivers/xen/manage.c b/drivers/xen/manage.c
> index cd046684e0d1..3190d0ecb52e 100644
> --- a/drivers/xen/manage.c
> +++ b/drivers/xen/manage.c
> @@ -204,6 +204,13 @@ static void do_poweroff(void)
>   static void do_reboot(void)
>   {
>   	shutting_down = SHUTDOWN_POWEROFF; /* ? */
> +	/*
> +	 * The systemd may be configured to mask ctrl-alt-del via
> +	 * "systemctl mask ctrl-alt-del.target". As a result, the pv reboot
> +	 * would not work. To enable C_A_D would force the reboot.
> +	 */
> +	C_A_D = 1;
> +
>   	ctrl_alt_del();
>   }
>   
> 

