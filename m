Return-Path: <SRS0=kGB5=CE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF315C433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 13:54:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8B09C208E4
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 13:54:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598450081;
	bh=Fk7gxuA24E9tzAw4KMxn84xJNQo/KTyyA409rVaoAqM=;
	h=Date:From:To:To:To:To:Cc:Cc:Cc:Subject:In-Reply-To:References:
	 List-ID:From;
	b=0TJnlC5LB7DMzos9U7McvFSbBY/OA9DaicaDyb0D7v+2c6AXJRUxnagBRDi3d8Ulz
	 Ih6BmTZDD8fmZ0bK3z+6LieO7pGgUzM6BqVNz/tS1poZvheB/LS0dR1GAQrmZPHqe6
	 Lb2gTd1XZzz1cN95dwLz81QnKm7qJj9ZIep2az54=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730572AbgHZNyk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Aug 2020 09:54:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:33168 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730522AbgHZNyO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Aug 2020 09:54:14 -0400
Received: from localhost (unknown [70.37.104.77])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D615F22B4E;
        Wed, 26 Aug 2020 13:54:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598450054;
        bh=Fk7gxuA24E9tzAw4KMxn84xJNQo/KTyyA409rVaoAqM=;
        h=Date:From:To:To:To:To:Cc:Cc:Cc:Subject:In-Reply-To:References:
         From;
        b=C9TQIBJ2dR4RE4qGM1dExos/cRKe6EXVVlAQMKaKt3Tc4Uh2y16OA1QSBONwGwxmQ
         d9C4xHOgUUfJJZ28oE36v93Wk6na5uxNaKuxLByYd2yATsqtdKIrnQVWfjIk0SfZMs
         sogsTTcilfnzyPxNQlfFa9haYMcDqpHLIpWD/b4M=
Date:   Wed, 26 Aug 2020 13:54:13 +0000
From:   Sasha Levin <sashal@kernel.org>
To:     Sasha Levin <sashal@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
To:     Andy Lutomirski <luto@kernel.org>
To:     x86@kernel.org
Cc:     linux-kernel@vger.kernel.org, Kyle Huey <me@kylehuey.com>
Cc:     stable@vger.kernel.org
Cc:     stable@vger.kernel.org
Subject: Re: [PATCH 1/7] x86/debug: Allow a single level of #DB recursion
In-Reply-To: <20200820104905.118636133@infradead.org>
References: <20200820104905.118636133@infradead.org>
Message-Id: <20200826135413.D615F22B4E@mail.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

[This is an automated email]

This commit has been processed because it contains a "Fixes:" tag
fixing commit: 9f58fdde95c9 ("x86/db: Split out dr6/7 handling").

The bot has tested the following trees: v5.8.2.

v5.8.2: Failed to apply! Possible dependencies:
    0b085e68f407 ("x86/entry: Consolidate 32/64 bit syscall entry")
    27d6b4d14f5c ("x86/entry: Use generic syscall entry function")
    517e499227be ("x86/entry: Cleanup idtentry_entry/exit_user")
    8d5ea35c5e91 ("x86/entry: Consolidate check_user_regs()")
    a377ac1cd9d7 ("x86/entry: Move user return notifier out of loop")
    b037b09b9058 ("x86/entry: Rename idtentry_enter/exit_cond_rcu() to idtentry_enter/exit()")
    ba1f2b2eaa2a ("x86/entry: Fix NMI vs IRQ state tracking")


NOTE: The patch will not be queued to stable trees until it is upstream.

How should we proceed with this patch?

-- 
Thanks
Sasha
