Return-Path: <SRS0=bYqs=33=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43D33C35247
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Feb 2020 00:29:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0628C2064C
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Feb 2020 00:29:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xc8Z/Z7z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727068AbgBGA3p (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Feb 2020 19:29:45 -0500
Received: from mail-oi1-f172.google.com ([209.85.167.172]:47092 "EHLO
        mail-oi1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726509AbgBGA3o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Feb 2020 19:29:44 -0500
Received: by mail-oi1-f172.google.com with SMTP id a22so298170oid.13
        for <linux-kernel@vger.kernel.org>; Thu, 06 Feb 2020 16:29:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Arv02iLyucfrWhjoT4PIeFYYDbMF6rJfuKmTY5LxKSw=;
        b=Xc8Z/Z7zUyXFZ/ESYFbvhzVtLkrUR99WgJgwh2uYmq/OWsQfkwICIM4mytuq2c7b3n
         PxPjXzh1WLFMDatXp+gZupFCkYLgI3asQfqWbbLhAclpIS//rk4Y3PoxLzarHAniukCq
         +xDexLMRTt+7VU4v14eZ89y6hnkKUD5mscYw2jucjuwL8qNVDZNBDhOsTwPFwPxGA4Vf
         aJI1gFdaU5yjx/nARNq/AqGUNBJ1rjzzsyJzpRE+7Y/8en1gjMMfCOI4w9cntYFt8aRD
         2KjzYZYqLjp9fq1tvoqWNOU6C4kF3v68SmfW131MSIgQxVWrgwc/HpSfzayiqHhAaoT4
         pIsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Arv02iLyucfrWhjoT4PIeFYYDbMF6rJfuKmTY5LxKSw=;
        b=XO+F4KM07Np0Aei4itT5RhaUnYF1nsWjyOvURKGjAlDqOVQIv3mdD4eYNNy5dNv2xQ
         HNz1CvGs2Z/MAs5JPqYlalzk1v7O1toTEkVK00msezFe43yidrzi4/hnKAU0tX3VppK/
         HmjyGOIRhL05iI6hZI2mTKn51gNNnLFXUD9n4sNMhNBpCzgumQTK3jj+QEu0fVnwBJ8q
         YgEa7Hnf79mPEtQcQ1IL8kpY8sDSuLkyu1OfI/bZkNVrnSFM/irbF7dntZIE4wUnIcSX
         rbDpg3fm8dWEdmdwovD1yWPEBwdzGxtyIev5dKGcFVcl9pKfE92iFasZsQbp1uwsRIcQ
         5gxA==
X-Gm-Message-State: APjAAAUk5K3AzE5dxFKGg0d7zNjPoRddImeBqmGsk/+3fPb8vFgsaFVS
        sawiTq/88j9rlVensWZO/AvhEk/0
X-Google-Smtp-Source: APXvYqx0iMPniHmAHxmLkQDABn+/McrVBkbJzxAtCswi/bYhFLWS24UjtXDCGMTdCjzBXqru7chPFA==
X-Received: by 2002:aca:54cc:: with SMTP id i195mr321159oib.126.1581035383731;
        Thu, 06 Feb 2020 16:29:43 -0800 (PST)
Received: from [192.168.1.120] (cpe-24-31-245-230.kc.res.rr.com. [24.31.245.230])
        by smtp.gmail.com with ESMTPSA id t132sm473712oie.8.2020.02.06.16.29.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Feb 2020 16:29:43 -0800 (PST)
Subject: Re: Error building v5.5-git on PowerPC32 - bisected to commit
 7befe621ff81
To:     Arvind Sankar <nivedita@alum.mit.edu>
Cc:     =?UTF-8?B?VmlsbGUgU3lyasOkbMOk?= <ville.syrjala@linux.intel.com>,
        Tom Anderson <thomasanderson@google.com>,
        Hans Verkuil <hansverk@cisco.com>,
        Manasi Navare <manasi.d.navare@intel.com>,
        LKML <linux-kernel@vger.kernel.org>
References: <0fb64c98-57c2-b988-051c-6ba0e460ad37@lwfinger.net>
 <20200206231211.GA2976063@rani.riverdale.lan>
 <20200206233325.GA3036478@rani.riverdale.lan>
From:   Larry Finger <Larry.Finger@lwfinger.net>
Message-ID: <cda542ae-e0ea-a9bc-53bc-8e91e06d254d@lwfinger.net>
Date:   Thu, 6 Feb 2020 18:29:42 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.2
MIME-Version: 1.0
In-Reply-To: <20200206233325.GA3036478@rani.riverdale.lan>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/6/20 5:33 PM, Arvind Sankar wrote:
> On Thu, Feb 06, 2020 at 06:12:13PM -0500, Arvind Sankar wrote:
>> On Thu, Feb 06, 2020 at 04:46:52PM -0600, Larry Finger wrote:
>>> When building post V5.5 on my PowerBook G4 Aluminum, the build failed with the
>>> following error:
>>
>> It's not that the attributes are wrong. The problem is that BUILD_BUG_ON
>> requires a compile-time evaluatable condition. gcc-4.6 is apparently not
>> good enough at optimizing to reduce that expression to a constant,
>> though it was able to do it with the array accesses.
> 
> Should have noted, it fails on x86 too with gcc-4.6.4, not specific to PPC.

What pre-processor test would be correct to skip the test for gcc4?

Larry

