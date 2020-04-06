Return-Path: <SRS0=Zj89=5W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9ABFBC2BA19
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 13:51:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 54D2E23370
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 13:51:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mev.co.uk header.i=@mev.co.uk header.b="RwgsTpCV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728415AbgDFNvy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Apr 2020 09:51:54 -0400
Received: from smtp65.iad3a.emailsrvr.com ([173.203.187.65]:50370 "EHLO
        smtp65.iad3a.emailsrvr.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728087AbgDFNvy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Apr 2020 09:51:54 -0400
X-Greylist: delayed 340 seconds by postgrey-1.27 at vger.kernel.org; Mon, 06 Apr 2020 09:51:53 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mev.co.uk;
        s=20190130-41we5z8j; t=1586180773;
        bh=sx2GlTr1skgOMXpKH+SQvrYKaP6Enh0lTplHmXPTNik=;
        h=Subject:To:From:Date:From;
        b=RwgsTpCVtnWo4PMfPnROwtBYJIBV1+3EcSfnu+cJ3EevPf583Us7n0CxMHPHas/M5
         5F1TpjK399HZNECibwwQR96StBM09VI+bEBPxB5wW6nY+/ItGc3Ph0YqK74JeamS9Y
         retU886mpZLrjwPesNHv6DCW1/igNTdAU8kmNLns=
X-Auth-ID: abbotti@mev.co.uk
Received: by smtp17.relay.iad3a.emailsrvr.com (Authenticated sender: abbotti-AT-mev.co.uk) with ESMTPSA id B2E5625590;
        Mon,  6 Apr 2020 09:46:12 -0400 (EDT)
X-Sender-Id: abbotti@mev.co.uk
Received: from [10.0.0.173] (remote.quintadena.com [81.133.34.160])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA)
        by 0.0.0.0:465 (trex/5.7.12);
        Mon, 06 Apr 2020 09:46:13 -0400
Subject: Re: [PATCH] Staging: comedi: dt2815: remove set but not used variable
 'hi'
To:     Wang Hai <wanghai38@huawei.com>, hsweeten@visionengravers.com,
        gregkh@linuxfoundation.org
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
References: <1586264372-15872-1-git-send-email-wanghai38@huawei.com>
From:   Ian Abbott <abbotti@mev.co.uk>
Organization: MEV Ltd.
Message-ID: <7e76bc61-7f3e-4bc8-4687-dd6d82c23dc1@mev.co.uk>
Date:   Mon, 6 Apr 2020 14:46:11 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <1586264372-15872-1-git-send-email-wanghai38@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-Classification-ID: a405988f-90a9-4235-8856-dcf8a6351cf0-1-1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/04/2020 13:59, Wang Hai wrote:
> Fixes gcc '-Wunused-but-set-variable' warning:
> 
> drivers/staging/comedi/drivers/dt2815.c: In function dt2815_ao_insn:
> drivers/staging/comedi/drivers/dt2815.c:91:19: warning: variable 'hi' set but not used [-Wunused-but-set-variable]
> 
> commit d6a929b7608a ("Staging: comedi: add dt2815 driver")
> involved this, remove it.
> 
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Wang Hai <wanghai38@huawei.com>
> ---
>   drivers/staging/comedi/drivers/dt2815.c | 3 +--
>   1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/staging/comedi/drivers/dt2815.c b/drivers/staging/comedi/drivers/dt2815.c
> index 83026ba..bcf85ec 100644
> --- a/drivers/staging/comedi/drivers/dt2815.c
> +++ b/drivers/staging/comedi/drivers/dt2815.c
> @@ -88,12 +88,11 @@ static int dt2815_ao_insn(struct comedi_device *dev, struct comedi_subdevice *s,
>   	struct dt2815_private *devpriv = dev->private;
>   	int i;
>   	int chan = CR_CHAN(insn->chanspec);
> -	unsigned int lo, hi;
> +	unsigned int lo;
>   	int ret;
>   
>   	for (i = 0; i < insn->n; i++) {
>   		lo = ((data[i] & 0x0f) << 4) | (chan << 1) | 0x01;
> -		hi = (data[i] & 0xff0) >> 4;
>   
>   		ret = comedi_timeout(dev, s, insn, dt2815_ao_status, 0x00);
>   		if (ret)
> 

That 'hi' value should be written to the hardware, but the driver is 
broken.  I don't think this driver has ever been tested as working 
because it has never written the 'hi' value to the hardware!

I think I know how to fix it.  I'll send a patch.

-- 
-=( Ian Abbott <abbotti@mev.co.uk> || Web: www.mev.co.uk )=-
-=( MEV Ltd. is a company registered in England & Wales. )=-
-=( Registered number: 02862268.  Registered address:    )=-
-=( 15 West Park Road, Bramhall, STOCKPORT, SK7 3JZ, UK. )=-
