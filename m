Return-Path: <SRS0=NqQd=7Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01144C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 17:19:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D3EB720829
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 17:19:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591895955;
	bh=QmEC/D+/Z+/WnEqYwpg0V9yt/eM232gVKnPY5hVJ2z0=;
	h=To:Cc:From:Subject:Date:List-ID:From;
	b=FlY1jtOcs3apLoPfQrbQylmZUXiU5X5sYA/J0UPXpbaoQW9MgOw/NGyDLtbC16PHX
	 cQ3LqfE9TimtP+WBDumOTzbPjEpuqvJeNAbEMkM11DU0oNjSVit5IE5LUUP80rLIJu
	 hcRyncSrPhQ5tVqzK60x/LPz1tCsAXdrIhsZfk0Y=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726719AbgFKRTH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Jun 2020 13:19:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726379AbgFKRTG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Jun 2020 13:19:06 -0400
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com [IPv6:2607:f8b0:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 443C0C03E96F
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jun 2020 10:19:06 -0700 (PDT)
Received: by mail-ot1-x332.google.com with SMTP id n6so5159845otl.0
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jun 2020 10:19:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=QmEC/D+/Z+/WnEqYwpg0V9yt/eM232gVKnPY5hVJ2z0=;
        b=ge/bgXeMCT8E7HfNRN1nBeLCz8TE9Nb16ugVR40XJEC2OZ7pLOAXqZ8E+WSmb7hUWm
         WKHW56F0Xz+AS879QnaphWHsI99fetW8e+dqNAbEFtLF5YDnKMlwDresOgJTZsTrZbqQ
         ZWVGYjQUZgRwTtpqok9YY54qseLpjYNdpHOX4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=QmEC/D+/Z+/WnEqYwpg0V9yt/eM232gVKnPY5hVJ2z0=;
        b=i7Yz963DqLOz7F342M2R+znky+LjtY7D4TWaFSi/bOTqNY7jIECdraoYc8xveshcFm
         PAoDHRtcBrVD1PJLaGnZMP9UValZKdBR7IjfGUqpTDwWkVrKq+3gPIbJutUmoTOCDW8A
         QT+13YazEnUpIwm9eNqHLQuaaV8CKgFzzq7k37YifTUe3TRnHEE9MdTVwnjsG2jTwhH5
         WCqyoF3x1raoU1xYQMM4FFgD57DpTyyRioy4dNTg/ikKWMZbV4bAmSFMBroVrq7MBFpm
         yHXLYhLaICzQKl0ah+gTRHJsmEz2GjsxOGeamUCEdn3sjylz/ziw6c8jmY9Bpm66mrqs
         o+Vg==
X-Gm-Message-State: AOAM531dvupXE3eSzN7bAggRQ/L1IcKbdj1dGebPHZ0lCjdpTb0OOYkx
        hWSJsxysZHLMg7oSkwzWTJ6g1A==
X-Google-Smtp-Source: ABdhPJxFwlP7VSwOjSjU+Far4PvIKauQOLXS9NaKOhMTPOysK0qYWMJsxBS1mvlS+RwIRngUfspEIQ==
X-Received: by 2002:a9d:7e8d:: with SMTP id m13mr7329252otp.64.1591895945554;
        Thu, 11 Jun 2020 10:19:05 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id x191sm791840oix.35.2020.06.11.10.19.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Jun 2020 10:19:04 -0700 (PDT)
To:     linux-kernel@vger.kernel.org
Cc:     skhan@linuxfoundation.org
From:   Shuah Khan <skhan@linuxfoundation.org>
Subject: [ANN] Call for projects for Linux Kernel Mentorship Fall 2020
Message-ID: <2d8968e2-ee75-dfd2-06f6-7c5473283522@linuxfoundation.org>
Date:   Thu, 11 Jun 2020 11:19:04 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I am reaching out for project proposals for Linux Kernel Mentorship
Fall 2020 session.

This program is designed to help developers with necessary skills — many
of whom are first-time open source contributors — experiment, learn, and
contribute effectively to open source communities.

You can find program overview and details at

https://wiki.linuxfoundation.org/lkmp

If you would like to mentor and have a project for a new developer,
please send a short summary of a project which can be completed in
3 months to me.

You can find in progress Summer projects and Fall projects for
reference at

https://wiki.linuxfoundation.org/lkmp/lkmp_project_list

thanks,
-- Shuah
