Return-Path: <SRS0=+FT0=45=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE749C1975A
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 13:57:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 88568206E7
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 13:57:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="AVrW7+rS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727445AbgCLN5b (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Mar 2020 09:57:31 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:37135 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727007AbgCLN5b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Mar 2020 09:57:31 -0400
Received: by mail-io1-f67.google.com with SMTP id k4so5767797ior.4
        for <linux-kernel@vger.kernel.org>; Thu, 12 Mar 2020 06:57:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=PmCzpDN/NMRhyTEmPMiyBIQCmmnvomJEacJijlrbzM4=;
        b=AVrW7+rSwrTmOjEOzng0oQCcIDCWV2si013XLwgHe6kixGzc7dstefqkGGSrsRVsAa
         FJE5c8jj9IlF0m0dMAhvHAI8L2U5z6bsisEYr8MliPCpIKguC+xfFP8F0WTnFm4+b0bq
         Fifux4zNzTJyMwxaYofa0zz8c/fczmTMV72sT6ZMw2K/qkUWZFqYOeB4JqKYqXOoDy7G
         m/lS4YnuTImXVHmsWTGe4vzNuDCRyyv0A6mKgrn7VmUN3Ao6sR9KYbWhRQSAUju2PiMf
         TRnCHWJ9L0Q9+VL2EyBZ5TsRl92cRG+4ULNLFYL+96dQGAluT2xt8/JIWGS0S5p/BZ2g
         j/dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=PmCzpDN/NMRhyTEmPMiyBIQCmmnvomJEacJijlrbzM4=;
        b=UlPbY9/AtpMEaHhKUW2KSpxDAI/UcKoPEj7gbHvhNGfB/vu43wmE9TSb/icuEpobzs
         uLhOCmp5NZR5XZkrJxA1sb69vifdkdYrlBImAxJSF0Bw2tprbCmCRmHdZQKK9Bjpp0oQ
         sIFCy07FefsfGnnUCgRGdU79dpl+2+Cy6LlToIkzIs1I3s+7ZKZt3KD/1OR8xcMEstC3
         M0XZz0OFibucgV7d5fR8GPtCLgsygLGMTQkMH7UNXC0PMFPPvqeYlVZH+rWMRQZr13V/
         JgboSWxKt03Mebj+zU0K20Pb7P6AbbjaBsLuvYhL9lcRIopF1X+Pn2fcJA8SYRMFTvC0
         mM8w==
X-Gm-Message-State: ANhLgQ0ObjGbADOnEXW54gideRmIRrvMmcEQjvT+uVodcrpL80y1aBxk
        5w9+6m2WK4lD0oOkaeR2i7XoSygJjJjZQg==
X-Google-Smtp-Source: ADFU+vv2B+H/3LrqYARnBvPi2opWl74wLabWcxLtVxSOKqH6WxbIDjQIp2v88SeHkhRQtUCt0kQj6w==
X-Received: by 2002:a5d:9708:: with SMTP id h8mr7755881iol.141.1584021448333;
        Thu, 12 Mar 2020 06:57:28 -0700 (PDT)
Received: from [192.168.1.159] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id r29sm8822455ilk.76.2020.03.12.06.57.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Mar 2020 06:57:27 -0700 (PDT)
Subject: Re: [PATCH 1/1] null_blk: describe the usage of fault injection param
To:     Dongli Zhang <dongli.zhang@oracle.com>, linux-block@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org
References: <20200304191644.25220-1-dongli.zhang@oracle.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <052ba0ac-e0ec-9607-e5c8-acbee8ab6162@kernel.dk>
Date:   Thu, 12 Mar 2020 07:57:26 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200304191644.25220-1-dongli.zhang@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/4/20 12:16 PM, Dongli Zhang wrote:
> As null_blk is a very good start point to test block layer, this patch adds
> description and comments to 'timeout' and 'requeue' to explain how to use
> fault injection with null_blk.
> 
> The nvme has similar with nvme_core.fail_request in the form of comment.

This doesn't apply to for-5.7/drivers, care to resend?

-- 
Jens Axboe

