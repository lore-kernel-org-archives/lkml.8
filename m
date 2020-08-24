Return-Path: <SRS0=wYIT=CC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9B24C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 12:30:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9680B20706
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 12:30:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZuNKvYZS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726820AbgHXMae (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Aug 2020 08:30:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726701AbgHXMaW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Aug 2020 08:30:22 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BA97C061573
        for <linux-kernel@vger.kernel.org>; Mon, 24 Aug 2020 05:30:22 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id a5so8508523wrm.6
        for <linux-kernel@vger.kernel.org>; Mon, 24 Aug 2020 05:30:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:cc:subject:from:message-id:date:user-agent:mime-version
         :content-transfer-encoding:content-language;
        bh=blQn2SeVbxEcBnI1jOs2oREomx/oG80KsgGc3h/X+KA=;
        b=ZuNKvYZSYGfhn8824cXto5npj56NW3P7euqQOjYTWYNJ4lu4qz2Y9MVvS99KNPhyPK
         d8boenarX1LiYIqGtylF/9CfEr/Kat7hO3SJxGhSbBA5xRvgZPQgHBSfP8lwK7SHjlg5
         JZUxY5aumiid+ZgBKYjsTNT/Wg8TydVuhfEeZWDOoYH42SWiHWd0dXuj/tnYRiInrZVb
         bL397hBXWlx1F6gawKb7P/j5duSV2d9RC/1gGvB1hs1NXvrE1W78TTfTpwaOn39y84H+
         zNpCY3UgQ17FqiFEwRCak3scr5gE80NSfiEwdQAQctxbZZhDJgJRAIP8Y436z7OQWntB
         v0uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:subject:from:message-id:date:user-agent
         :mime-version:content-transfer-encoding:content-language;
        bh=blQn2SeVbxEcBnI1jOs2oREomx/oG80KsgGc3h/X+KA=;
        b=P6RVdGTnJQ4a7TKbwJepQVxlV95NQp8S9P3g0V8PycQCD4CEELOJa/XZWrxdARZvC+
         VHUQR8+CMbrBs7tFcwPUUivzBpj8f21QVhL4wKFBS34qW/zITRFRc3yWgW9H/c06W0Nz
         WDFlJ6k0MYcbV24WxJnBNycznWr4pWGbmbnOQJNKW/TmJD0gFNQ59GokVhLQhk8+ETL1
         ZSrxpOYNVgG3zP9u5S40dPMJ1Lp/QH6ECGGO5nIWqt4tPMVw6eVnGNsqNkaOKwdw9+Hs
         8EOsXcyCrWs1cssCNtgu23LlMGR2Qpnx/RBP6f194wWnBeRh02m8MM01hb02Hk09XJcE
         Vnrg==
X-Gm-Message-State: AOAM530RYteMQiBhZTFofIGVpgCMDAcc1FimMTv1PZ+QzZQsTWIpCLL5
        5gvqKiW9fEayQe/CEwltOZg=
X-Google-Smtp-Source: ABdhPJxMLm4saLPlC7reRegXV0MuiDRWXTOhyevhA90VQPUJX/W4kTYybr1DXavVW/x+lajNcNxryQ==
X-Received: by 2002:adf:f151:: with SMTP id y17mr6004761wro.179.1598272220819;
        Mon, 24 Aug 2020 05:30:20 -0700 (PDT)
Received: from [192.168.0.16] (cpc83661-brig20-2-0-cust443.3-3.cable.virginm.net. [82.28.105.188])
        by smtp.gmail.com with ESMTPSA id k204sm26860359wma.21.2020.08.24.05.30.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Aug 2020 05:30:20 -0700 (PDT)
To:     adrien.crivelli@gmail.com
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        perex@perex.cz, tiwai@suse.com
Subject: Re: [PATCH] ALSA: hda/realtek: Add quirk for Samsung Galaxy Book Ion
 15 inches
From:   Alex Dewar <alex.dewar90@gmail.com>
Message-ID: <7210c752-0a1f-3985-91f0-b70facf0293c@gmail.com>
Date:   Mon, 24 Aug 2020 13:30:18 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-GB
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There's a mistake in this. The ID numbers are the wrong way round.

Alex
