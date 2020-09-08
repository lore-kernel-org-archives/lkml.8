Return-Path: <SRS0=o+hd=CR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64E91C433E2
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 18:47:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1DDF321919
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 18:47:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="AaOjm4P5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731466AbgIHSnc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Sep 2020 14:43:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726434AbgIHSm0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Sep 2020 14:42:26 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10271C061755
        for <linux-kernel@vger.kernel.org>; Tue,  8 Sep 2020 11:42:26 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id w186so170021pgb.8
        for <linux-kernel@vger.kernel.org>; Tue, 08 Sep 2020 11:42:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=HikxOknzrc1XVTFwFB+7qtr+uDYCyFNi+S2PjioEX08=;
        b=AaOjm4P5hKS1xhOSqH9yvXniWJjm9ZqhdSjJpI4Iv9dya5zqq3koHZQ+HH1qafFsEy
         EQT0HLLyCHqNgh877jz5ApbjUHFUZ0c4EDB56EIB1NZVK5BjQQaBF4vvKCmcu1NfK25d
         DjvQcaffCJuZQ5Epc3wgEpqoZ6Wx6dzLsCU8o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HikxOknzrc1XVTFwFB+7qtr+uDYCyFNi+S2PjioEX08=;
        b=O5aQddR94PjuuSstMnUkgoxYVadRVf3aiXN3k1pINA+qCg4AyB1cckchIkGbdbuIRl
         JAQV/v4mFjTjPiy6or3bIHy7Qipf/+iEX2w7MHfsXmVeTRvFGjQgo0a/05HFbyN91B9+
         iJitwqvpqx7imSh4Hldz7n9gzQz1Lb9wAiUi6jSI67SgNpwfEKxeQTd+dZiTuavRIMa0
         nrgXf9S8qXKqmk9YHFVdfSvaA5FGPMgtdOlWh7S55CWYi4joY6ZoYys9uAlOweO1CU94
         G1UYjzdlf0n7QoPly/+N0fCp4YgwOcRMoz3luU1A191a4cWXeD0lffjUSxcwvJZ7Dy8N
         Umpg==
X-Gm-Message-State: AOAM533vNC7GA8mTiE3vP/harZljhnO2c5pDDp47cI0I6em1QpgTNXzv
        wLHImgq5rtbfKZ0e2cTRCMORnjHkw36pvQ==
X-Google-Smtp-Source: ABdhPJyAS3/74tHj0MdPt2VyQ3sQU5CZIDZvpiRiKCQrdYl5Fl839Yfe3ZPuVSTMdD2GxAo/+sKrYw==
X-Received: by 2002:a62:b608:: with SMTP id j8mr132926pff.126.1599590545650;
        Tue, 08 Sep 2020 11:42:25 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id q71sm37722pja.9.2020.09.08.11.42.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Sep 2020 11:42:24 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Tycho Andersen <tycho@tycho.pizza>
Cc:     Kees Cook <keescook@chromium.org>, linux-kernel@vger.kernel.org,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Christian Brauner <christian@brauner.io>
Subject: Re: [PATCH] seccomp: don't leave dangling ->notif if file allocation fails
Date:   Tue,  8 Sep 2020 11:41:54 -0700
Message-Id: <159959050861.1264035.3217861807726166263.b4-ty@chromium.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200902140953.1201956-1-tycho@tycho.pizza>
References: <20200902140953.1201956-1-tycho@tycho.pizza>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2 Sep 2020 08:09:53 -0600, Tycho Andersen wrote:
> Christian and Kees both pointed out that this is a bit sloppy to open-code
> both places, and Christian points out that we leave a dangling pointer to
> ->notif if file allocation fails. Since we check ->notif for null in order
> to determine if it's ok to install a filter, this means people won't be
> able to install a filter if the file allocation fails for some reason, even
> if they subsequently should be able to.
> 
> [...]

Applied, thanks!

[1/1] seccomp: don't leave dangling ->notif if file allocation fails
      https://git.kernel.org/kees/c/e839317900e9

as featured on my Twitch stream! ;)

-- 
Kees Cook

