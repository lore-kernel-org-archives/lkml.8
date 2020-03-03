Return-Path: <SRS0=fZJt=4U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6593C3F2C6
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 07:08:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8111720CC7
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 07:08:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=4net.rs header.i=@4net.rs header.b="q+6FUDIS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727548AbgCCHIM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Mar 2020 02:08:12 -0500
Received: from amazon.4net.rs ([159.69.148.70]:40608 "EHLO amazon.4net.rs"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725440AbgCCHIM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Mar 2020 02:08:12 -0500
Received: from localhost (amazon.4net.co.rs [127.0.0.1])
        by amazon.4net.rs (Postfix) with ESMTP id A90556308DA5;
        Tue,  3 Mar 2020 08:08:10 +0100 (CET)
X-Virus-Scanned: amavisd-new at 4net.rs
Received: from amazon.4net.rs ([127.0.0.1])
        by localhost (amazon.dyn.4net.co.rs [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id jvoIUfjkylYN; Tue,  3 Mar 2020 08:08:09 +0100 (CET)
Received: from mail.4net.rs (green.4net.rs [10.188.221.8])
        by amazon.4net.rs (Postfix) with ESMTP id CBDBA6308DA3;
        Tue,  3 Mar 2020 08:08:09 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by mail.4net.rs (Postfix) with ESMTP id 8CB8BCB7B785E;
        Tue,  3 Mar 2020 08:08:09 +0100 (CET)
X-Virus-Scanned: amavisd-new at 4net.rs
Received: from mail.4net.rs ([127.0.0.1])
        by localhost (green.4net.rs [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id mWQk5sHWq3_6; Tue,  3 Mar 2020 08:08:09 +0100 (CET)
Received: from mail.4net.rs (localhost [127.0.0.1])
        by mail.4net.rs (Postfix) with ESMTP id 65106C9AA7822;
        Tue,  3 Mar 2020 08:08:09 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=4net.rs; h=subject:to:cc
        :references:from:message-id:date:mime-version:in-reply-to
        :content-type:content-transfer-encoding; s=4netrs; bh=EX/iTcpszK
        0Ez1dpjbfxtmz1eo8=; b=q+6FUDISiI0OHo4p53AHwm1ti3Qgt0JhCnRjttNOcQ
        GBpcGVF3KW4aJQz9VgHUYPd5wwY15Zm+muk3iA3hpx+XZPBZQaXOEtd0jAjbrnJG
        4JjxDinO1YXI43gueHX3g0uZD/ynXf0lH1+g3v6NzNqE2zq2aWXgLWBa/RTvapuZ
        0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=4net.rs; h=subject:to:cc
        :references:from:message-id:date:mime-version:in-reply-to
        :content-type:content-transfer-encoding; q=dns; s=4netrs; b=nxho
        JU6k4O6gJ+tZESC/S8BWSTcZczEEpVuvGaq4+dZ531AWrYF5XI11aIkufIs9VvTv
        kF9RRNepdqUA2YDHAsR3Ds50TJ6/JoFufMvReLbb4Lf4A2YODoqntbdh0ReHT3ND
        0rTaqE2jCSuR3AxQm46K9o9KGVZEAKcE+tTl4kY=
Received: from [127.0.0.1] (localhost [127.0.0.1])
        by mail.4net.rs (Postfix) with ESMTPSA id 3953ECB7B785E;
        Tue,  3 Mar 2020 08:08:09 +0100 (CET)
Subject: Re: [Intel-gfx] Linux 5.6-rc2
To:     linux-kernel@vger.kernel.org
Cc:     intel-gfx@lists.freedesktop.org
References: <CAHk-=wgqwiBLGvwTqU2kJEPNmafPpPe_K0XgBU-A58M+mkwpgQ@mail.gmail.com>
 <99fb887f-4a1b-6c15-64a6-9d089773cdd4@4net.rs>
 <CAPM=9ty3NuSHBd+StNGxVCE9jkmppQ_VTr+jMRgB07qW3dRwrA@mail.gmail.com>
 <f9081410ef1135003720fa29d27aa10b9d12d509.camel@intel.com>
 <a1c918b663805e8213a1229edb87883c@4net.rs> <87sgiqpu1s.fsf@intel.com>
From:   Sinisa <sinisa@4net.rs>
Message-ID: <5d9ef6ef-7bde-172f-f35d-14e1cc98c0b4@4net.rs>
Date:   Tue, 3 Mar 2020 08:08:09 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <87sgiqpu1s.fsf@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/2/20 6:04 PM, Jani Nikula wrote:
> On Mon, 02 Mar 2020, Siniša Bandin <sinisa@4net.rs> wrote:
>> Sorry to bother, but still a "no go" in rc4 (at the same time, 5.5.7
>> works OK).
>>
>> Is there anything else I could do to help fix this?
> Please wait for the patch to be actually merged to Linus' tree. I assume
> it'll make it to v5.6-rc5.
>
> Thanks,
> Jani.
OK, thank you.

I'll wait patiently...

Srdačan pozdrav / Best regards / Freundliche Grüße / Cordialement,
Siniša Bandin

