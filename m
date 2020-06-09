Return-Path: <SRS0=F/Af=7W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04095C433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 13:17:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BF54520737
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 13:17:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=perex.cz header.i=@perex.cz header.b="WvAeGGBA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729987AbgFINRA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jun 2020 09:17:00 -0400
Received: from mail1.perex.cz ([77.48.224.245]:33654 "EHLO mail1.perex.cz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729968AbgFINQz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jun 2020 09:16:55 -0400
Received: from mail1.perex.cz (localhost [127.0.0.1])
        by smtp1.perex.cz (Perex's E-mail Delivery System) with ESMTP id B823CA003F;
        Tue,  9 Jun 2020 15:16:52 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.perex.cz B823CA003F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=perex.cz; s=default;
        t=1591708612; bh=Q6pAyvWAA5MDPmhkXsBCOnRP+oa87wANg1kmgbc1Kpc=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=WvAeGGBAMKiFOFjTPXv8K3w5I1fxEZVOhQaZiXlSH1MVoJCMwtDLsMxaOSFHber3c
         L1N+Ix+80HnPbrBixJ0V62C0B7d0XedIZzq/bLDST90WHVbtdXfgzYan8OfYvWB76T
         tZVa+PvCOJTQmgNlwOSN0GHaj8vF3zuHqiiSmrAI=
Received: from p50.perex-int.cz (unknown [192.168.100.94])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: perex)
        by mail1.perex.cz (Perex's E-mail Delivery System) with ESMTPSA;
        Tue,  9 Jun 2020 15:16:38 +0200 (CEST)
Subject: Re: next-0519 on thinkpad x60: sound related? window manager crash
To:     Christoph Hellwig <hch@lst.de>, Takashi Iwai <tiwai@suse.de>
Cc:     David Rientjes <rientjes@google.com>,
        "Alex Xu (Hello71)" <alex_y_xu@yahoo.ca>,
        alsa-devel@alsa-project.org, bp@alien8.de, hch@infradead.org,
        hpa@zytor.com, linux-kernel@vger.kernel.org, mingo@redhat.com,
        Pavel Machek <pavel@ucw.cz>, tglx@linutronix.de,
        tiwai@suse.com, x86@kernel.org
References: <20200609054306.GA9606@lst.de> <s5hsgf4irzt.wl-tiwai@suse.de>
 <20200609084305.GA21671@lst.de> <s5hlfkwip1h.wl-tiwai@suse.de>
 <20200609091727.GA23814@lst.de> <s5hh7vkio0n.wl-tiwai@suse.de>
 <20200609113123.GA547@lst.de> <s5h3674ii49.wl-tiwai@suse.de>
 <20200609114059.GA1228@lst.de> <s5hzh9ch38h.wl-tiwai@suse.de>
 <20200609114955.GA2027@lst.de>
From:   Jaroslav Kysela <perex@perex.cz>
Message-ID: <a20ab909-bb60-8d47-0da3-122a724aecbe@perex.cz>
Date:   Tue, 9 Jun 2020 15:16:38 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200609114955.GA2027@lst.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dne 09. 06. 20 v 13:49 Christoph Hellwig napsal(a):
> On Tue, Jun 09, 2020 at 01:45:34PM +0200, Takashi Iwai wrote:
>> Yes, for the sound stuff, something below should make things working.
>> But it means that we'll lose the SG-buffer allocation and the
>> allocation of large buffers might fail on some machines.
> 
> We crossed lines there.  In general due to better memory compaction and
> CMA we have better chances to get larger contiguous allocations these
> days, so this might not be too much of an issue in practice.
> 

But turning off the SG DMA scheme seems like a step back. Would be possible to 
fix this kind of memory mapping?

					Jaroslav


-- 
Jaroslav Kysela <perex@perex.cz>
Linux Sound Maintainer; ALSA Project; Red Hat, Inc.
