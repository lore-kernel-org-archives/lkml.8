Return-Path: <SRS0=eGSO=AR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34C39C433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 23:05:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 03E5B206E9
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 23:05:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="t4uNP1fY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727895AbgGFXFT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jul 2020 19:05:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727058AbgGFXFT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jul 2020 19:05:19 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 176EEC061755
        for <linux-kernel@vger.kernel.org>; Mon,  6 Jul 2020 16:05:19 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id r12so43011486wrj.13
        for <linux-kernel@vger.kernel.org>; Mon, 06 Jul 2020 16:05:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:cc:references:from:autocrypt:subject:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=n8WSN9OO6JhOeCOLUTvTw9tkEo0SsW93xx3ZZdZXMI0=;
        b=t4uNP1fYn/DHReNGk+z+aOSomulpnZvJb/3FC2AfFWFF4Sef1vc45vJ+rjsWKgFI+F
         /VdeeKzg1BDJL8sYxVoyd421IhRJgvmMvkZgD2aDuZCFicU1g0P6+FmclLiVm39jGywg
         dTfI0c7acnoU2SMjIZO7lNh1vxjxkgOaq/ljeNzSILFs++HGhRFj35HYvB2vl5yOJ54t
         TcV/PAd3L2OGXQIVCkT3iR2JFopblVRi1/lNiqhbWN0NrcbtZJuwwyWbHWFuZs7vLq64
         +z0tec/IpCRc/Oj1U2jtfBmf5WG35Knyp8CF8Q45ATSVHAncjfMaPV23iknlltkzuFlW
         a/Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:references:from:autocrypt:subject
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=n8WSN9OO6JhOeCOLUTvTw9tkEo0SsW93xx3ZZdZXMI0=;
        b=Up27kTP5tf63us4Ip84do8Yl4LjyPj4szkgiJWEakzjU9vvvQSVYfAfTMukiptfgRH
         +tMMBI9WJNw+3TrUqMvrAzgiC1JNlxoCCtCuyouBoAL0c1U7LMfXjeBDc5Vt79IHJs58
         ZZVrPDpsqlFS2TiIxbZzEja4m0Q5USL6Tz6Es+KaVtVizS+SeqV+rPWWiIAUsksCpkVt
         L7W/nfaXp8FzlhdQgqFDciu09JwFhrDWvR8XKMDdEw6nb2zZw/dQl109S2Zj2oKRjH38
         efqxUwBt432KJYYh8y+iOnuKoynvbzNas0HkKo8n4ppYzFqbX6Q90JxBpTDr8fRVxonW
         FKLQ==
X-Gm-Message-State: AOAM532OLtRA3gnmneJn5EcU142jD3bvhb8v5wlWYXc6y2tEmImcUTTH
        fi4zlG1MrTUvTk3qgYCihiMDHfa3
X-Google-Smtp-Source: ABdhPJwMAv/rva34lQSp9P1OS5Iq4KaOvM/gVesHTFox3fcEvXJQTtyhz33re5Mh3bwjCAfr1p7ztA==
X-Received: by 2002:a5d:44c7:: with SMTP id z7mr54613087wrr.226.1594076717820;
        Mon, 06 Jul 2020 16:05:17 -0700 (PDT)
Received: from [192.168.43.52] ([5.100.193.69])
        by smtp.gmail.com with ESMTPSA id g14sm23186818wrw.83.2020.07.06.16.05.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Jul 2020 16:05:17 -0700 (PDT)
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Dan Williams <dan.j.williams@intel.com>,
        ksummit-discuss@lists.linuxfoundation.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org,
        tech-board-discuss@lists.linuxfoundation.org,
        torvalds@linux-foundation.org
References: <159389297140.2210796.13590142254668787525.stgit@dwillia2-desk3.amr.corp.intel.com>
 <1cceba0f-c8ad-260d-9a09-5417bee32d50@gmail.com>
 <20200706181052.174c290a@oasis.local.home>
 <717030b7-ecba-2ca4-39ff-6a5a04a732d4@gmail.com>
 <20200706182819.3467fa32@oasis.local.home>
From:   Pavel Begunkov <asml.silence@gmail.com>
Autocrypt: addr=asml.silence@gmail.com; prefer-encrypt=mutual; keydata=
 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 bA==
Subject: Re: [Tech-board-discuss] [PATCH] CodingStyle: Inclusive Terminology
Message-ID: <4592008a-16ee-d8c4-4ec3-5e36a268e5d6@gmail.com>
Date:   Tue, 7 Jul 2020 02:03:36 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <20200706182819.3467fa32@oasis.local.home>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/07/2020 01:28, Steven Rostedt wrote:
> On Tue, 7 Jul 2020 01:17:47 +0300
> Pavel Begunkov <asml.silence@gmail.com> wrote:
> 
>> Totally agree with you! But do we care then whether two _devices_ or _objects_
>> are slave-master? Can't see how it fundamentally differs.
> 
> The term slave carries a lot more meaning than subordinate. I replied to
> someone else but later realized that the person sent me their reply
> offlist, so my reply to them was also offlist. What I told them was,
> back in college (decades ago), when I first mentioned "master/slave" in
> conversation (I think it was about hard drives), a person in that
> conversation stated that those were not very nice terms to use. I blew
> it off back then, but after listening to more people, I found that
> using "slave" even to describe a device is not something that people
> care to hear about.

That's cultural, but honestly I've never seen such a person. I still
don't understand, why having secondary or subordinate object belittling
the owned side by not providing it the same rights and freedom is OK,
but slave/master objects are not. Where is the line?


> 
> And in actuality, does one device actually enslave another device? I
> think that terminology is misleading to begin with.

As mentioned, I do like good clear terminology, and if it conveys the idea
better, etc., then it's worth to try. And IMHO that's the right reasoning
that should be behind. Otherwise, for almost every word we can find a person
seeing something subjectively offensive or at least bad in it.

-- 
Pavel Begunkov
