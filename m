Return-Path: <SRS0=CsDi=3F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4BFFC32771
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 02:08:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9DCBE2081E
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 02:08:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BoOusHGT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730684AbgAPCI2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jan 2020 21:08:28 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:38134 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730192AbgAPCI2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jan 2020 21:08:28 -0500
Received: by mail-wm1-f65.google.com with SMTP id u2so2101883wmc.3
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jan 2020 18:08:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Nw+8ap5KvB9tm8bR+ynm6qNTGEmFydwpXlTdU/LQtwA=;
        b=BoOusHGTeoAOQgIya7AWRK1CqpG2xrET+MHEpnfROQRIf8fo2vGAoVdsScpG9wl/xY
         mQmxr1Y2AaB2Yj82Dd0z9pS44H2MVVX3GPfm2QCJVn/62psGdfOOTD8cBQk/lOiCA629
         cFo+hh2lKeoueux62aKI1KWFy61qAnJhQgyuxRngUAHjlQeCTqH5bNJK6g9bE2+BdR56
         s/3Umlcun+3k/5MtKmP16marIkaTLNQNy8Q/jBBuTemVSzewREXPZRfhYWSfiLXJX2Nk
         dbpIm8cP3odRD0/eHhW4zX9E1ymP2rvNOD/mW+rZL4JHqa+0BW+QwCCeif/S485OvSJu
         SPCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Nw+8ap5KvB9tm8bR+ynm6qNTGEmFydwpXlTdU/LQtwA=;
        b=Ta/b1KnzKTbLPcQjv2+nNChnBa1R+oT3yVE30jQcTZF3E0fxkG6AzbDJr+Xr+k/Yuh
         AbcX6RvYhcAI88YSWuRBBAa7m2o6R8SOzajdQyTmZVJcemcPevwn4EpBz5TWcP+a9VpI
         2N8Fhlbe6SPCkUyQ0oi/E/lN5ODWVnplShKdCIr/NpQPzeY1krUWHUrj75BmPK4hQb1d
         S1Nx0JSvcLNBMyU7dj1PDpXBGB6M+FKsw5m4k5zqzUncTyu1jsdvlfSMfx0qlxR5qr5N
         p3kksKyMf6rSSoDZgoYjEcknlErWMini4OzHxuyhUOX7fq6vX8QrQUpPiqMRYMjPw9bN
         QCVg==
X-Gm-Message-State: APjAAAUpaGhdlc4QE92h+cknW6XHzI4/VFak5/IEgxLOnzLDl9rFftZY
        exvyM3n4kPWAQabxsJ3shbjPpiMQUVQ=
X-Google-Smtp-Source: APXvYqzn5/8G7yf2sPCnIfKlQa6dtOqL28tssc7mm2P26g+svoQ0AcIVsGO0NxJujK2iRQkUNxSyJw==
X-Received: by 2002:a7b:c084:: with SMTP id r4mr3070057wmh.99.1579140505814;
        Wed, 15 Jan 2020 18:08:25 -0800 (PST)
Received: from [192.168.0.38] ([176.61.57.127])
        by smtp.gmail.com with ESMTPSA id x17sm26536901wrt.74.2020.01.15.18.08.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Jan 2020 18:08:25 -0800 (PST)
Subject: Re: linux-next: Fixes tag needs some work in the usb-gadget tree
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Felipe Balbi <balbi@kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20200116070726.7e2ef8cc@canb.auug.org.au>
 <b7ef5047-c8c3-42cc-d049-fb72563d3544@linaro.org>
 <20200116124100.58af81d5@canb.auug.org.au>
 <6b984328-b3f4-a23d-efb3-7e7955ad165a@linaro.org>
 <20200116125851.474f3021@canb.auug.org.au>
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Message-ID: <043cbd87-1d7d-e998-04a8-bbc9aec686df@linaro.org>
Date:   Thu, 16 Jan 2020 02:08:55 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <20200116125851.474f3021@canb.auug.org.au>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16/01/2020 01:58, Stephen Rothwell wrote:
> Hi Bryan,
> 
> On Thu, 16 Jan 2020 01:45:25 +0000 Bryan O'Donoghue <bryan.odonoghue@linaro.org> wrote:
>>
>> On 16/01/2020 01:41, Stephen Rothwell wrote:
>>> Hi Bryan,
>>>
>>> On Thu, 16 Jan 2020 01:19:22 +0000 Bryan O'Donoghue <bryan.odonoghue@linaro.org> wrote:
>>>>
>>>> How should extra long fixes like this be divided up ?
>>>
>>> Just let them run on even if they are too long i.e. don't split them at all.
>>
>> That's what's in the git commit log though isn't it ?
> 
> When you add a Fixes: tag to a commit, you quote the subject line of
> the commit you are fixing which, by definition, is a single line.  We
> want to keep it that way so it can be searched for easily.
> 
> So to create a fixes line you can use this:
> 
> git log -1 --format='Fixes: %h ("%s")' <commit being fixed>
> 
> i.e. in this case:
> 
> $ git log -1 --format='Fixes: %h (\"%s\")' 40d133d7f5426
> Fixes: 40d133d7f542 ("usb: gadget: f_ncm: convert to new function interface with backward compatibility")
> 

doh sorry still not seeing it

git remote -v
usb-next	git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git 
(fetch)

git fetch usb-next
git show 5b24c28cfe13

that's a correctly formatted fixes right i.e. the same one as above

:(

not seeing the difference...

---
bod
