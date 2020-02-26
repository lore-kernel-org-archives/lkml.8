Return-Path: <SRS0=/Zd0=4O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BD1EC4BA12
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 12:33:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1255420838
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 12:33:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=isovalent-com.20150623.gappssmtp.com header.i=@isovalent-com.20150623.gappssmtp.com header.b="hfdLuYaa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726963AbgBZMdd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Feb 2020 07:33:33 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:53236 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726476AbgBZMdb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Feb 2020 07:33:31 -0500
Received: by mail-wm1-f68.google.com with SMTP id p9so2869522wmc.2
        for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2020 04:33:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=0kIIo1lecMssMrTUasr4Z+ioUkeaNygIbZqpO6tuy7U=;
        b=hfdLuYaaUMr9SBi7O2P91IYzUJ/zTJ2oS0bgVO7G20Gc0lV6lmNPq/5xN/1yLoCaez
         Z886k1//kTzEvgQADorL1StdQJeX4DGQR8jUCS6NcH9TQ4ajegwlK8MTW8lSAx9x4rQ7
         JHl9KZSvefslwO/hLtvmU8a/DLORpxStfHfCtwxmM+bDuFE54j0UQ19th6tTAiL2Ojnl
         wmPMjYPD0FMF3XsqrCEuH3UXNW3YMO7ecvcZNjMqCxRtpRp07Gl2ticJbytLAviZW9eq
         7cuyBOK/SGF7WKkVXBzN4G4WnMyqe7nQpCgWzl7pV43jy+4h9MsX8cnBOwv85R/yVaPP
         o2Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=0kIIo1lecMssMrTUasr4Z+ioUkeaNygIbZqpO6tuy7U=;
        b=JAaASwF0BbJWZNxxgvTkh+RbdDwIqTVCz7JDlkyBlY/afpG3aoLBzSLLCYXoQ+bzxv
         Pt6Mc/iH8nUwPNVtS7C2bayskQ9Kwl2REKfRvf4bwEK5Jq1jJ5HUBiAux1StRzSsdsGM
         N+OxuzYucyn7wCIqowl9u2THbIlX2VDq57WH0YGwZycKHGjj8EBg2KC/QTKwjlbMvFju
         j/9FT1+9b3Rox5hWX5ueGOat0qeu3jz9Azr2U8hJLtdgwRY/3aC/lUxQwDEUgxHmvJpb
         EvS60r9+b7iGzijsP3lvDYtsnZtvzvLg4UG7r1Vxqto2wgsgDnJgvWIFpbG9tjftD/rd
         isdA==
X-Gm-Message-State: APjAAAV+PheJRm9K8YDf03zd9VaSZfHiDDkWANvUiErGXEqFn3NmLiqQ
        QKUzyTYfcq0qcDPWuiTAdutBTA==
X-Google-Smtp-Source: APXvYqzF4DjO+4GDUDHWRvcM3JgEw8aRfM0WfUIcWWSC7lry6yZFBDyky7ZCIKYhYahJy5QAQ29yoA==
X-Received: by 2002:a1c:6189:: with SMTP id v131mr5646682wmb.185.1582720409669;
        Wed, 26 Feb 2020 04:33:29 -0800 (PST)
Received: from [192.168.1.10] ([194.35.116.65])
        by smtp.gmail.com with ESMTPSA id a62sm2785097wmh.33.2020.02.26.04.33.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Feb 2020 04:33:29 -0800 (PST)
Subject: Re: [PATCH bpf-next v3 0/5] bpftool: Make probes which emit dmesg
 warnings optional
To:     Michal Rostecki <mrostecki@opensuse.org>, bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        Andrii Nakryiko <andriin@fb.com>,
        Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, Shuah Khan <shuah@kernel.org>,
        linux-kselftest@vger.kernel.org
References: <20200225194446.20651-1-mrostecki@opensuse.org>
 <e4929660-21ff-e394-37a0-d72b67a3770a@isovalent.com>
 <0e46d001-a137-97bc-262c-e864cf3f90b8@opensuse.org>
From:   Quentin Monnet <quentin@isovalent.com>
Message-ID: <b638238e-7e35-0ab0-3f0b-315ffd947a8c@isovalent.com>
Date:   Wed, 26 Feb 2020 12:33:28 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <0e46d001-a137-97bc-262c-e864cf3f90b8@opensuse.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2020-02-26 13:17 UTC+0100 ~ Michal Rostecki <mrostecki@opensuse.org>

[...]

> I
> might follow up with some more tests covering the other subcommands in
> future.

That would be great!
Thanks,
Quentin
