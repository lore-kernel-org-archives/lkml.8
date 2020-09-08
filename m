Return-Path: <SRS0=o+hd=CR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8117C43461
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 19:45:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5E59B20578
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 19:45:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ak3qkOov"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732291AbgIHTo7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Sep 2020 15:44:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731791AbgIHTou (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Sep 2020 15:44:50 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B368C061573
        for <linux-kernel@vger.kernel.org>; Tue,  8 Sep 2020 12:44:49 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id b124so2129pfg.13
        for <linux-kernel@vger.kernel.org>; Tue, 08 Sep 2020 12:44:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2RAh9VxYe6YP3CQOqoPiJgS/OiFbrrin8Z9n6iaYo5M=;
        b=ak3qkOov/dSJu+P+iQr+bMPZsrf0r3uxQjSSawEZ313S717j11P5xv13s0bIThq041
         JQWiNt6rvsUa87j+AKNInb8B0hmZOLSiYMWoh09BhNCNHqV+b5ZAZhJTEuP0A+2L+w2R
         voncG799mvL/eZRxEPzWTjNtx4Sf6N6CVI5TQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2RAh9VxYe6YP3CQOqoPiJgS/OiFbrrin8Z9n6iaYo5M=;
        b=ddwbZIE/NGJgExfO2wjRrBLEp6/ECp5gBhXuoT2Ej8zW693A+3eCTz5szziMtHXh2F
         +BaHUalX79HWMChXReuIMVfcUNNs+ZV+nxJNZTeScy6NsZgauCfTm+49CV3uvjClYeNn
         A2Q0NO3fu5GsR2gF4/XsKb0ShvTVMvY0D4p+Y0YpdrO7J8hgoixid3/0iL1cNtORwFIx
         9cKyOyHaaEBzT5gruHb0blVjyOM9HxfM2AkE2zlhjbwb42nyfehHDTnE+3DnEIMkSK5l
         EROpuiWY0R+Hpp/X70wfNVU9Hhht4tdo5+khHfxLjXcA1+L8SCe1Y9CePiP7jkOzBPEk
         dLiA==
X-Gm-Message-State: AOAM530dDYVWDwUQPAzKvKaCbu6BVuc1kItG5Pzb+55AHd/4yWE0aUDG
        dB0tRny5t6t2cDhUp3R4Fd+kFw==
X-Google-Smtp-Source: ABdhPJxVV2IHdBHOtNGRGXN1IUlBfQlG699HAitMd8MACvmx3uO30Lg9o4pb84yyKXNWsBXBENJzhg==
X-Received: by 2002:a63:7f59:: with SMTP id p25mr268271pgn.146.1599594288289;
        Tue, 08 Sep 2020 12:44:48 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id j144sm224712pfd.106.2020.09.08.12.44.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Sep 2020 12:44:47 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     linux-kernel@vger.kernel.org, Rich Felker <dalias@libc.org>
Cc:     Kees Cook <keescook@chromium.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Will Drewry <wad@chromium.org>
Subject: Re: [PATCH] seccomp: kill process instead of thread for unknown actions
Date:   Tue,  8 Sep 2020 12:43:43 -0700
Message-Id: <159959421548.1668991.14680355869966635620.b4-ty@chromium.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200829015609.GA32566@brightrain.aerifal.cx>
References: <20200829015609.GA32566@brightrain.aerifal.cx>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 28 Aug 2020 21:56:13 -0400, Rich Felker wrote:
> Asynchronous termination of a thread outside of the userspace thread
> library's knowledge is an unsafe operation that leaves the process in
> an inconsistent, corrupt, and possibly unrecoverable state. In order
> to make new actions that may be added in the future safe on kernels
> not aware of them, change the default action from
> SECCOMP_RET_KILL_THREAD to SECCOMP_RET_KILL_PROCESS.

Applied, thanks!

[1/1] seccomp: kill process instead of thread for unknown actions
      https://git.kernel.org/kees/c/4d671d922d51

I tweaked the coredump logic and added a selftest (and CCed you) for
the behavior (since it wasn't included in the existing tests).

-- 
Kees Cook

