Return-Path: <SRS0=+GcV=BG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B9D6C433E8
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 21:31:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CA6772075D
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 21:31:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=labbott.name header.i=@labbott.name header.b="FanrqO//"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726918AbgG0Vbz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jul 2020 17:31:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726139AbgG0Vbz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jul 2020 17:31:55 -0400
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com [IPv6:2607:f8b0:4864:20::82b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E41C2C061794
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jul 2020 14:31:54 -0700 (PDT)
Received: by mail-qt1-x82b.google.com with SMTP id x12so4907973qtp.1
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jul 2020 14:31:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=labbott.name; s=google;
        h=from:subject:to:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=PZXDxl3tnsooH7FVoXBl3fMcl7z8koIKfGqiVcv4xhI=;
        b=FanrqO//r0Ii9x48h8vHfPMkVa3164p3CR9xlteWzLvdhyfg1AUXqJdm6LmVq8IAA2
         i9cxLEQCgl4DKdDX/eYAYtrkyBA96rND5SljR7hQNqqv06wru9R+D2g7fR/dUCf1gfAY
         XiDjgnGRahZkVUH70DxhGbY2TlCTQTzF2q600=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=PZXDxl3tnsooH7FVoXBl3fMcl7z8koIKfGqiVcv4xhI=;
        b=i6RuRfLksrjuddtuIwZOd6UZucKcsnauUUa5H7pyqtjtYvv3kuzj6VRMm0Nh1+CFC8
         mks0nWyj/jmjAqZrKydcy86h8iLiCyizaeSIdefMYxJmDbD0R+1Bi1cYgO+93lquj/9Q
         xMYq5LuNVLKhop7STFATl4mRPH9A4om6BNttAJXuScWmFf75kGwLD++SoHWYK8dcPiPa
         Ha1h07CgmUCQm4+8hQjKnJ0GxSyVz0XuDI6DNUpEphoMO1l3XrIlHT8Z91rBgp8fRfZt
         qRydpKg362PkzoQLrFkUSY3xqkGrIXVoQym1/G0IJgEWgnvIa46fshhie2WlYyytK5Ae
         8RQQ==
X-Gm-Message-State: AOAM530wXZgvZvntUdofaPBErc6kHNjbJuNVFgRPICuFe53DInK1K9NR
        MErUWqs0SavUYwc1LLMaCfRfHjgeKrhwDg==
X-Google-Smtp-Source: ABdhPJwm4zhQVD3XZEFaQ29kZt7WrpbLczLhA+m5mzManqqnCKZrElgBfiWR0KqfWL4aH3a73MD0Ew==
X-Received: by 2002:ac8:660f:: with SMTP id c15mr6666249qtp.34.1595885513868;
        Mon, 27 Jul 2020 14:31:53 -0700 (PDT)
Received: from [192.168.1.168] (pool-74-109-246-95.pitbpa.fios.verizon.net. [74.109.246.95])
        by smtp.gmail.com with ESMTPSA id x29sm17316904qtx.74.2020.07.27.14.31.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Jul 2020 14:31:53 -0700 (PDT)
From:   Laura Abbott <laura@labbott.name>
Subject: Linux Foundation Technical Advisory Board Elections -- voting
 procedures
To:     "tech-board-discuss@lists.linuxfoundation.org" 
        <tech-board-discuss@lists.linuxfoundation.org>,
        "ksummit-discuss@lists.linuxfoundation.org" 
        <ksummit-discuss@lists.linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Message-ID: <ade3420c-89fd-bed0-52e3-a0396eaeda2d@labbott.name>
Date:   Mon, 27 Jul 2020 17:31:53 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On behalf of the Linux Foundation Technical Advisory Board (TAB), I'd
like to announce the voting procedures for the 2020 TAB elections.
The pool of eligible voters will consist of the following:

1) All attendees of the Linux Plumbers conference (i.e. kernel summit)

2) Anyone who is not a kernel summit attendee will also be eligible to
vote if the following criteria are met:
-- There exists three kernel commits in a mainline or stable released
kernel that
--- Have a commit date in the year 2019 or 2020
--- Contain an e-mail address in one of the following tags or merged
tags (e.g. Reviewed-and-tested-by)
---- Signed-off-by
---- Tested-by
---- Reported-by
---- Reviewed-by
---- Acked-by

We will be using the electronic voting method that we used in 2019. All
Linux Plumbers Attendees will automatically receive a ballot. Anyone
who is otherwise eligible to vote should e-mail 
tab-elections@lists.linuxfoundation.org to request a ballot. The deadline
for requesting a ballot is August 17, 00:00 UTC (one week before
Linux Plumbers)

For those who would like to know the thought process behind this:

Last year, we successfully used electronic voting for the TAB
elections. Given the circumstances of this year, we have no other
reasonable option for voting. While we could continue to limit voting to
kernel summit attendees, one of the goals of moving away from in person
voting was to potentially expand the voter pool. Since kernel summit is
not being held in person this year, it makes sense to expand the voting
pool at the same time.

We will be sending a call for nominations and announcements about
when voting will start at a later date.

If you have any questions, feel free to reach out to the tab at
tab@lists.linuxfoundation.org
