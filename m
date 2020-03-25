Return-Path: <SRS0=vy7l=5K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D266FC1975A
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 15:11:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A28B420719
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 15:11:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="Bgi2pL0Y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727642AbgCYPL6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Mar 2020 11:11:58 -0400
Received: from mail-pl1-f171.google.com ([209.85.214.171]:33644 "EHLO
        mail-pl1-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726969AbgCYPL6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Mar 2020 11:11:58 -0400
Received: by mail-pl1-f171.google.com with SMTP id g18so919155plq.0
        for <linux-kernel@vger.kernel.org>; Wed, 25 Mar 2020 08:11:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=odeneEdONR8grSoihowwuREl6SAzgo70YaaaeKd/NpQ=;
        b=Bgi2pL0YttlAbAQ73ifCSqGufCdzu80yX+RwuK0Cr4qZkga5F/vOeEcZ3SmF5/rxlT
         eLQT8KQX4jl1EEkFig+TehDSjlMl4sS9cqCKv6ZP0Bq6To7mMhF/FjLbkCB4BNKO3g7g
         /o3RvWq6XcC1Ep+tKnoFNt54hcNGxvswvwVfAQk7gAUTlqDAE85QMv1/EcVqnzHA9lat
         pjirYEIMxdirjaURSXSPYCNhv3pl4jqqQhrgdo73Iree7pvMGj7xXuASmScFTz94Yoj+
         4YryxJs2ZMIE2U2f/cDC1vgwLNDxaQKjHHkAERDacaBmjmk9K4hWJadKv5WQHmzxfqDH
         mQOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=odeneEdONR8grSoihowwuREl6SAzgo70YaaaeKd/NpQ=;
        b=UD8VJY5NwQY5ODlDDVzn5Dgtam3XwUvls97TggZyXCHlET7QxN6YQeOSV5rfAuqLWq
         aA2p2RM7wIQ6cbElRL6ejMrbrXMUxMQJxSpQ6AVxoqxEFQnWVyanemMKp8gCa13xXqeS
         4hYt1xCQv4gYStaU+W3fkMvfiv6vEwWc/Z4d5vTRfdH+AKwSf3ZTelKrX8346vF5qIJ7
         +r6RV/4opNybmPa1+nnOeQFgmoABR4tnCOXxrTsusCrDDJXejBRlfYHZAmCTsuxHavVm
         il477hGxWv1Zghw9qOgxSASSSMMVQeKlOb2oWglzl3Coi0L3dwhWqw+L1vdZwAwJjnkx
         ozbg==
X-Gm-Message-State: ANhLgQ1pjmCcLgCTyOoOnNfYCAHeNJWkix9vbFtJht4LxNw3S2gJZQFT
        zhVgK/BNSJ5ff8xWCcec6kJpMOqZFrh0FQ==
X-Google-Smtp-Source: ADFU+vua1+fKJkCuFU81kPz90wA3YXpegsrlLTveHbex3keCG+MmUUofz6eaQImAkWD9Mh/cRF0H3Q==
X-Received: by 2002:a17:902:76ca:: with SMTP id j10mr3586522plt.184.1585149116391;
        Wed, 25 Mar 2020 08:11:56 -0700 (PDT)
Received: from [192.168.1.188] ([66.219.217.145])
        by smtp.gmail.com with ESMTPSA id 144sm17138984pgc.25.2020.03.25.08.11.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Mar 2020 08:11:55 -0700 (PDT)
Subject: Re: decruft genhd.h
To:     Christoph Hellwig <hch@lst.de>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20200325110338.1029232-1-hch@lst.de>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <b6bac2cc-4657-0004-b69d-68f51ef429e0@kernel.dk>
Date:   Wed, 25 Mar 2020 09:11:54 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200325110338.1029232-1-hch@lst.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/25/20 5:03 AM, Christoph Hellwig wrote:
> Hi Jens,
> 
> this series tries to move as much out of genhd.h that doesn't really
> belong there.

Can you resend against the current 5.7/block? The second to last
patch throws a trivial reject, and I could fix this up, but the
last one moves code that has now changed slightly and it'd be better
if you could rebase and re-test.

This is due to the stat fixups that I queued up this morning.

-- 
Jens Axboe

