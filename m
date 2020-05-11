Return-Path: <SRS0=ABJN=6Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C23F3C54E8D
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 15:11:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9DA7420736
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 15:11:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="a0YmaQD5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730293AbgEKPLj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 May 2020 11:11:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729439AbgEKPLi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 May 2020 11:11:38 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85A18C061A0C
        for <linux-kernel@vger.kernel.org>; Mon, 11 May 2020 08:11:37 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id f15so4065538plr.3
        for <linux-kernel@vger.kernel.org>; Mon, 11 May 2020 08:11:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=b6Qn6mnglPMeun+F122gj7FdZziWAjQdfWb0bchyv2Q=;
        b=a0YmaQD5EyntmGhmrWH8GvLZc94jLG3PXfmLpdLMclvbcbeSohfJJHVwjK5CP+b12W
         i0+yQ7HQ7B2EIG3iFylWhQflc+gbBzkK+qVOt+W2/c4X7AAjbo/FhgmVuklu7H1kBSaL
         d61yyk9sFGsVXqnNv4dI7Ja5GbS9FXdVzVoGgQAFQTP+PoJbrm+sFjdygn+0rz5HWAbu
         FjHLP6ojk9Q6zc4WW+tRrBpAsLQrPTD03iUFDqKbbm2Vth3MAjUuRnL+4vli8FktgkfP
         ltHHlgsxWxa160JIdtIPKma1gn09YwlIEdB/ILfPPsxtF3SmtJmvXAaXweBHNfapQImF
         hseA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=b6Qn6mnglPMeun+F122gj7FdZziWAjQdfWb0bchyv2Q=;
        b=EWcHzyZn5u/W+6kCi2PcCKUiAyQTti1HNls2lLgLu4nWZ/rAmhGVPdI0+J13jps0tM
         uP2wVNeIWPq+Npq0Jk1GY+C0FaCtU0b8CfDH/Yplt0JhdMVxvaZMdwOaV9MRktPZE3wg
         zaEdNCeAPRtQHLNI5pfmocPUyCwHkhXK0IOFPAMcfOR97IHHzSxWgPzq+C3SVrSlVSlg
         +TUZRqEn+UMyAjslfVae+17UnQNx4S0K9LEX2LY+tyYQ/xf3QOgXCGvzpC6r06JKG4SF
         mPLPlKIzeXh4mwS62+T3DvV66T6U1EwKC611CJ13yYLiUpbFru51PV5uzezzzU3B16w9
         OMrQ==
X-Gm-Message-State: AGi0PuZZqpdm1zxuz7F/VgVEbKeck70hjhGAs3KIFIq/yCjmECvKuHm9
        wU3fMA5sTSy45bPrnS3gKNQo2w==
X-Google-Smtp-Source: APiQypLEgcFBhRnw2eIsSGKc6JL+MC5Hhl5LIq1art1ImaP9tNSH+IGyHUMouz8JBPnAdPLfa0yv6A==
X-Received: by 2002:a17:90a:cd03:: with SMTP id d3mr22989849pju.233.1589209896940;
        Mon, 11 May 2020 08:11:36 -0700 (PDT)
Received: from ?IPv6:2605:e000:100e:8c61:2dd6:4c58:486d:263e? ([2605:e000:100e:8c61:2dd6:4c58:486d:263e])
        by smtp.gmail.com with ESMTPSA id i9sm9501044pfk.199.2020.05.11.08.11.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 May 2020 08:11:36 -0700 (PDT)
Subject: Re: [LKP] Re: [pipe] f2af7d90e2: xfstests.btrfs.052.fail
To:     Li Zhijian <zhijianx.li@intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        kernel test robot <rong.a.chen@intel.com>
Cc:     0day robot <lkp@intel.com>, LKML <linux-kernel@vger.kernel.org>,
        lkp@lists.01.org
References: <20200511010957.GW5770@shao2-debian>
 <20200511011601.GV16070@bombadil.infradead.org>
 <b6cb98f4-4265-b518-f692-d56d3fb1cad5@intel.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <b3fa7cd0-60da-fbc1-7d66-28f2923fd389@kernel.dk>
Date:   Mon, 11 May 2020 09:11:34 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <b6cb98f4-4265-b518-f692-d56d3fb1cad5@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/10/20 10:06 PM, Li Zhijian wrote:
> Hi Matthew
> 
> with a quick look into the dmesg
> looks this commit broke the preparation of LKP tests
> 
> [   32.677588] install debs round two: dpkg -i --force-confdef 
> --force-depends /opt/deb/gawk_1%3a4.1.4+dfsg-1_amd64.deb
> [ 32.677593]-
> [   32.697180] tar: ./control: Cannot write: Invalid argument
> [ 32.697184]-
> [   32.705025] tar: ./md5sums: Cannot write: Invalid argument
> [ 32.705030]-
> [   32.710034] tar: ./postinst: Cannot write: Invalid argument
> [ 32.710039]-
> [   32.743721] tar: ./prerm: Cannot write: Invalid argument

The patch does look broken, as per discussions with Al on the equiv
eventfd change, it's not complete. It's also not queued up anywhere,
just posted for review, and subsequently dropped (for now).

So feel free to ignore it.

-- 
Jens Axboe

