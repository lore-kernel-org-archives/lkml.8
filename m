Return-Path: <SRS0=o+hd=CR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EE03C2BC11
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 21:23:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 323F82145D
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 21:23:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="W3Pr3Jck"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730184AbgIHVXW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Sep 2020 17:23:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730161AbgIHVXM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Sep 2020 17:23:12 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 953ADC061573
        for <linux-kernel@vger.kernel.org>; Tue,  8 Sep 2020 14:23:10 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id 67so434597pgd.12
        for <linux-kernel@vger.kernel.org>; Tue, 08 Sep 2020 14:23:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ih6QbdC2BlMXbYNA/XrG1Rz+rSEU4l2iSukj1ZYcfcE=;
        b=W3Pr3JckrBkhsvVBPRqyalyPCHmDdjwsO8lMz82fl3992mSkJBCa/ynKYFlOpa29KS
         YrQvjiSk8Gsj+2F0XyIFg6bT/TX3bdtqIzg+X9zApTyghMxBvgeVK7VjGnj0Xvez1x1T
         vtDDvMHWVF2Q9VElpy4Et4CUBV2fAGlDpuHSIHxSfO2vTMGl2CEODJDA3aVOsYuSr2rb
         54oZUVIzZ6F0vJ0E2vHEj9aGY9uEozAJoPE35B9/ZkY30GF+FwBSaPHMJZxUW1Gwmrih
         hraJxCrNOD15xVsyVUJ11S0Z4yNK+aS0/3uKyQbwkUQtxQoq+M+Ub2vQlfRLbEhbUoo0
         TnTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ih6QbdC2BlMXbYNA/XrG1Rz+rSEU4l2iSukj1ZYcfcE=;
        b=d5AJxaZO/2rKEyQIzRo7OPlfl/aRb1l+N3HCd3okj+nloQZjV3lUZ4SqUELUooftpS
         CcKktF/Kvy5eyLEj92cWQHvoRQhfsOqVaYTvcUP76d2RGxUO7vo4mo6OAeAlSQr4T+Za
         EciGeVxtT0aoyBb/ti91CTbhFbRT5fbZDh5HfUhmWQvcBLj7DxnTAY8nX5OklXv0kxZ8
         0OFDX/RWz1DN15+xIqLs/fkro69m8uHyYawDIERbqh02I/s+GAOotELeuDKwS5ZIhcmx
         MTPGKH9dqb/S4A7QivV1/CSnsJ3GmqL7LeVkY8GBWC0mfYpblWs5bq8rlaQtKVbw0GI9
         hmew==
X-Gm-Message-State: AOAM5328JmYZBTKCWtjirjlHXqEfzlEAXUpxXZC5f7JtmCquF+0ZCGSk
        WUuJgl2+by0BZCDTOevfz7DkdA==
X-Google-Smtp-Source: ABdhPJxZtQ6suAAYIvComwJnL/d5p58yR7wkXLgcU+gM/W/qIhxDDa8Jsi9la7BgYDO45OUXHd5G6Q==
X-Received: by 2002:a05:6a00:1356:b029:13e:d13d:a084 with SMTP id k22-20020a056a001356b029013ed13da084mr947839pfu.27.1599600189879;
        Tue, 08 Sep 2020 14:23:09 -0700 (PDT)
Received: from google.com ([2620:15c:201:2:f693:9fff:fef4:1b6d])
        by smtp.gmail.com with ESMTPSA id gk14sm161668pjb.41.2020.09.08.14.23.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Sep 2020 14:23:09 -0700 (PDT)
Date:   Tue, 8 Sep 2020 14:23:02 -0700
From:   Sami Tolvanen <samitolvanen@google.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        clang-built-linux@googlegroups.com,
        kernel-hardening@lists.openwall.com, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kbuild@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        x86@kernel.org
Subject: Re: [PATCH v2 22/28] arm64: export CC_USING_PATCHABLE_FUNCTION_ENTRY
Message-ID: <20200908212302.GD1060586@google.com>
References: <20200624203200.78870-1-samitolvanen@google.com>
 <20200903203053.3411268-1-samitolvanen@google.com>
 <20200903203053.3411268-23-samitolvanen@google.com>
 <202009031544.D66F02D407@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202009031544.D66F02D407@keescook>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 03, 2020 at 03:44:18PM -0700, Kees Cook wrote:
> On Thu, Sep 03, 2020 at 01:30:47PM -0700, Sami Tolvanen wrote:
> > Since arm64 does not use -pg in CC_FLAGS_FTRACE with
> > DYNAMIC_FTRACE_WITH_REGS, skip running recordmcount by
> > exporting CC_USING_PATCHABLE_FUNCTION_ENTRY.
> > 
> > Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
> 
> How stand-alone is this? Does it depend on the earlier mcount fixes?

It does, because exporting CC_USING_PATCHABLE_FUNCTION_ENTRY doesn't
change anything without the earlier mcount changes.

Sami
