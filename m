Return-Path: <SRS0=PJcK=74=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 747EFC433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 20:54:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4A2A320768
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 20:54:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592254444;
	bh=dHcMhx3Tk3i6+4c/+Ci/fK6T8fJVbOY2yPS/JAtcgEs=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:List-ID:From;
	b=Pt2U+hiV72Ui1lQeVx3hGRQsEL5lHuLhWL0X3mFrvx6CXiuXnN09nTRW10jlTEIo0
	 UMsXLFVA4voS43N+eiQ374Ygj+SjpuxDGe6V4uZ3e5FKhUDVQguLz4ULltJCupHJ1a
	 luKis6evS0RqtKpBq9yeDFVQYcRxFDRFyPpRjqX8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731704AbgFOUyD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jun 2020 16:54:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731179AbgFOUyB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jun 2020 16:54:01 -0400
Received: from mail-ot1-x342.google.com (mail-ot1-x342.google.com [IPv6:2607:f8b0:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8BFCC061A0E
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jun 2020 13:54:01 -0700 (PDT)
Received: by mail-ot1-x342.google.com with SMTP id s13so14220008otd.7
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jun 2020 13:54:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=aMCQ/9D2OL2UejJnLf26RX0B0w7nFrQsSW8m/RdY+mo=;
        b=gn93Gv+4NaenIVQ3MR1LGLbB6ngFaKVCRGE/gV6RtjAX1MQ9Rs1FvSBOvIlfLhprZu
         S7/OyfzE+Yh44ezwvUrQyF7Ly8LrzuhF1/TsNteoSZD55rPKqOJd+VsZ6j0ejAwq8KIh
         vD0O0CZT+UnDlpBHrM45upyA2l3UpL2UcoQzk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=aMCQ/9D2OL2UejJnLf26RX0B0w7nFrQsSW8m/RdY+mo=;
        b=HzsIvgpaAtMgShXQxJ9YKVERhDRcftRksuxxsxMDBGhnSVlrw9XrDyRJ1WQiRTYUrR
         X1XxpibyP54KrEerzUngYTHuokGWpe6wEXzLas0ZiUre33++JNql0q5229lu/x48UoPu
         Ont8f9lpwKPwmmD4+Ko+btwbsWTOAJJCojXdb8HSfaLAZ2QXzha+bnxvx1xyZKOiW8rL
         eZuXgGMs8H71hcZ6cZD2eU/MISM946KM5Xe5Dw8r3xmIwdZo6sTmM9NgVFS50qxVcLgY
         RXNMTLgy0XSgVhjtW6kA3vE/V9b4XzQNBRCsGH3yqXWNIFrcRDdp+8AedJkBvcxdKwAf
         w+xA==
X-Gm-Message-State: AOAM5331koOFHdT1+OK3aGpmDlyuuHZ4FvYFeHpvcjEv0Ml4Bik/QybF
        OXt5SLYEzMA++Sf3dyR6oAmsZRNbwgs=
X-Google-Smtp-Source: ABdhPJwIW4UStaL4NITW83E2cwRWuWjMfmndGFRyxTGeT/DkZorBziDZapjbqdGBvxKwzqsk5VuGBg==
X-Received: by 2002:a9d:4503:: with SMTP id w3mr21904724ote.38.1592254441143;
        Mon, 15 Jun 2020 13:54:01 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id k14sm3463139oof.48.2020.06.15.13.54.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Jun 2020 13:54:00 -0700 (PDT)
Subject: Re: Linux 5.8-rc1 BUG unable to handle page fault (snd_pcm)
To:     Takashi Iwai <tiwai@suse.de>, David Rientjes <rientjes@google.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Shuah Khan <skhan@linuxfoundation.org>
References: <446c7a14-db97-6389-a03c-9ffccd251529@linuxfoundation.org>
 <s5hsgew2jbl.wl-tiwai@suse.de>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <ef100771-ae52-dd35-2d6b-762e5dda6e81@linuxfoundation.org>
Date:   Mon, 15 Jun 2020 14:53:59 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <s5hsgew2jbl.wl-tiwai@suse.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/15/20 1:57 PM, Takashi Iwai wrote:
> On Mon, 15 Jun 2020 20:48:11 +0200,
> Shuah Khan wrote:
>>
>> I am seeing the following problem on my system. I haven't started debug
>> yet. Is this a known issue?
> 
> Yes, the recent fix by David should paper over it:
>    http://lore.kernel.org/r/alpine.DEB.2.22.394.2006110025250.13899@chino.kir.corp.google.com
> IIRC, Christoph already merged it in his tree.
> 
> I also made another fix series in the sound driver side (found in
> topic/dma-fix2 branch in my sound.git tree).
> But I guess I'll queue it for 5.9 after more testing.
> 
> 

David and Takashi,

I applied the patch David pointed me to.

http://git.infradead.org/users/hch/dma-mapping.git/commitdiff/dbed452a078d56bc7f1abecc3edd6a75e8e4484e

I have CONFIG_AMD_MEM_ENCRYPT enabled. Building now. Will keep
you updated.

thanks,
-- Shuah

