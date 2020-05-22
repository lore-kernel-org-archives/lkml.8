Return-Path: <SRS0=AA2M=7E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2023FC433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 22 May 2020 22:40:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E54D120738
	for <linux-kernel@archiver.kernel.org>; Fri, 22 May 2020 22:40:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590187239;
	bh=nKJ+NR8Zq+TjBW09KzQrYnkOO8kcQo/Q4ZyZXpe3MRc=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:List-ID:From;
	b=ZdOCEM13r/eoi7NBoZGCxmVhePkjYnX0FAb8a4TZUcTxwzJb41yZquzl00R45eUO1
	 Nw2YegdQNlHB72bpHrHo5o1LDmww1x3lKZMRcbbzrs9LDZde+Kaqd7GfCJhsqo3Fqi
	 gxfJnbu6p2K6HCbyj+vDpF2yxc4pkZYlssbqciZw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731214AbgEVWki (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 May 2020 18:40:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:52518 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731029AbgEVWkh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 May 2020 18:40:37 -0400
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net [24.9.64.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 41FC1204EA;
        Fri, 22 May 2020 22:40:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590187237;
        bh=nKJ+NR8Zq+TjBW09KzQrYnkOO8kcQo/Q4ZyZXpe3MRc=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=WsppzdI8VXf4M+BwrdzL4O3DYOxOubNAwjRAvieTSPIKz+CS6yRT/m3/MzgOS9dSj
         lGaS9RcFvCS9zR82f/CQg2N/HRzXbW7VjExuBVbkiXeOW5eMgFrY4aAbLqMbQM43kz
         PS0bqCt/sGLzuFnpaw8MSwRBvCuFZseviJZc7etc=
Subject: Re: [PATCH] kunit: use KUnit defconfig by default
To:     Brendan Higgins <brendanhiggins@google.com>,
        Vitor Massaru Iha <vitor@massaru.org>
Cc:     KUnit Development <kunit-dev@googlegroups.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        linux-kernel-mentees@lists.linuxfoundation.org,
        shuah <shuah@kernel.org>
References: <20200414233753.94978-1-vitor@massaru.org>
 <CAFd5g442ka0c+D+qs7--_ERqn=Bqc3V4AHuER8FLsJi1oesirQ@mail.gmail.com>
From:   shuah <shuah@kernel.org>
Message-ID: <97d1f27d-7156-6207-73ae-fb06d2b218d6@kernel.org>
Date:   Fri, 22 May 2020 16:40:36 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <CAFd5g442ka0c+D+qs7--_ERqn=Bqc3V4AHuER8FLsJi1oesirQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/16/20 5:20 PM, Brendan Higgins wrote:
> On Tue, Apr 14, 2020 at 4:37 PM Vitor Massaru Iha <vitor@massaru.org> wrote:
>>
>> To improve the usability of KUnit, defconfig is used
>> by default if no kunitconfig is present.
>>
>>   * https://bugzilla.kernel.org/show_bug.cgi?id=205259
>>
>> Signed-off-by: Vitor Massaru Iha <vitor@massaru.org>
> 
> Reviewed-by: Brendan Higgins <brendanhiggins@google.com>
> 

Applied the patch to kselftest/kunit on top of

45ba7a893ad89114e773b3dc32f6431354c465d6
kunit: kunit_tool: Separate out config/build/exec/parse

from David's work resolving merge conflicts. Please check if it is
sane.

thanks,
-- Shuah
