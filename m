Return-Path: <SRS0=F/Af=7W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47AADC433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 18:44:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 351A220734
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 18:44:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732175AbgFISo5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jun 2020 14:44:57 -0400
Received: from mail.cybernetics.com ([173.71.130.66]:42822 "EHLO
        mail.cybernetics.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728400AbgFISo4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jun 2020 14:44:56 -0400
X-ASG-Debug-ID: 1591727320-0fb3b01c5812e320002-xx1T2L
Received: from cybernetics.com ([10.10.4.126]) by mail.cybernetics.com with ESMTP id NtCZY1jYz1zdanMg; Tue, 09 Jun 2020 14:28:41 -0400 (EDT)
X-Barracuda-Envelope-From: tonyb@cybernetics.com
X-ASG-Whitelist: Client
Received: from [10.157.1.18] (account tonyb HELO [192.168.200.1])
  by cybernetics.com (CommuniGate Pro SMTP 5.1.14)
  with ESMTPSA id 10019933; Tue, 09 Jun 2020 14:28:40 -0400
Subject: Re: [PATCH 3.16 42/61] scsi: sg: don't return bogus Sg_requests
To:     Ben Hutchings <ben@decadent.org.uk>, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
X-ASG-Orig-Subj: Re: [PATCH 3.16 42/61] scsi: sg: don't return bogus Sg_requests
Cc:     akpm@linux-foundation.org, Denis Kirjanov <kda@linux-powerpc.org>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        Andrey Konovalov <andreyknvl@google.com>,
        Christoph Hellwig <hch@lst.de>, Hannes Reinecke <hare@suse.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Doug Gilbert <dgilbert@interlog.com>
References: <lsq.1591725832.563793501@decadent.org.uk>
From:   Tony Battersby <tonyb@cybernetics.com>
Message-ID: <746e3939-9e5e-8610-5878-07330b2de87e@cybernetics.com>
Date:   Tue, 9 Jun 2020 14:28:40 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <lsq.1591725832.563793501@decadent.org.uk>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Barracuda-Connect: UNKNOWN[10.10.4.126]
X-Barracuda-Start-Time: 1591727321
X-Barracuda-URL: https://10.10.4.122:443/cgi-mod/mark.cgi
X-Barracuda-BRTS-Status: 1
X-Virus-Scanned: by bsmtpd at cybernetics.com
X-Barracuda-Scan-Msg-Size: 2809
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/9/20 2:04 PM, Ben Hutchings wrote:
> 3.16.85-rc1 review patch.  If anyone has any objections, please let me know.
>
> ------------------
>
> From: Johannes Thumshirn <jthumshirn@suse.de>
>
> commit 48ae8484e9fc324b4968d33c585e54bc98e44d61 upstream.
>
> If the list search in sg_get_rq_mark() fails to find a valid request, we
> return a bogus element. This then can later lead to a GPF in
> sg_remove_scat().
>
> So don't return bogus Sg_requests in sg_get_rq_mark() but NULL in case
> the list search doesn't find a valid request.
>
> Signed-off-by: Johannes Thumshirn <jthumshirn@suse.de>
> Reported-by: Andrey Konovalov <andreyknvl@google.com>
> Cc: Hannes Reinecke <hare@suse.de>
> Cc: Christoph Hellwig <hch@lst.de>
> Cc: Doug Gilbert <dgilbert@interlog.com>
> Reviewed-by: Hannes Reinecke <hare@suse.de>
> Acked-by: Doug Gilbert <dgilbert@interlog.com>
> Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
> Cc: Tony Battersby <tonyb@cybernetics.com>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
> ---
>  drivers/scsi/sg.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> --- a/drivers/scsi/sg.c
> +++ b/drivers/scsi/sg.c
> @@ -2085,11 +2085,12 @@ sg_get_rq_mark(Sg_fd * sfp, int pack_id)
>  		if ((1 == resp->done) && (!resp->sg_io_owned) &&
>  		    ((-1 == pack_id) || (resp->header.pack_id == pack_id))) {
>  			resp->done = 2;	/* guard against other readers */
> -			break;
> +			write_unlock_irqrestore(&sfp->rq_list_lock, iflags);
> +			return resp;
>  		}
>  	}
>  	write_unlock_irqrestore(&sfp->rq_list_lock, iflags);
> -	return resp;
> +	return NULL;
>  }
>  
>  /* always adds to end of list */
>
The following "cleanup" commit to the sg driver introduced a number of bugs:

109bade9c625 ("scsi: sg: use standard lists for sg_requests") (v4.12-rc1)

This one bad commit requires all of the following fixes:

48ae8484e9fc ("scsi: sg: don't return bogus Sg_requests") (v4.12-rc1)
bd46fc406b30 ("scsi: sg: off by one in sg_ioctl()") (v4.13-rc7)
4759df905a47 ("scsi: sg: factor out sg_fill_request_table()") (v4.14-rc1)
3e0097499839 ("scsi: sg: fixup infoleak when using SG_GET_REQUEST_TABLE") (v4.14-rc1)
587c3c9f286c ("scsi: sg: Re-fix off by one in sg_fill_request_table()") (v4.14-rc6)

AFAIK, there is no reason to backport any of these changes to -stable,
but if for some reason you do need to backport any one of these patches,
then make sure you get all of them.

My guess is that the initial buggy patch was backported to other -stable
trees because the fixes for it looked important, and of course the fixes
depended on the patch that introduced all of the problems to begin with.

Tony Battersby
Cybernetics
