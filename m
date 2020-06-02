Return-Path: <SRS0=QAx1=7P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 311BBC433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 23:10:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F3BF82072F
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 23:10:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="onppgC6J"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729057AbgFBXKH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jun 2020 19:10:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728414AbgFBXKG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jun 2020 19:10:06 -0400
Received: from mail-ed1-x542.google.com (mail-ed1-x542.google.com [IPv6:2a00:1450:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64B60C08C5C0
        for <linux-kernel@vger.kernel.org>; Tue,  2 Jun 2020 16:10:06 -0700 (PDT)
Received: by mail-ed1-x542.google.com with SMTP id c35so157149edf.5
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jun 2020 16:10:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=W6pIMQuCx2FvcQCQIr+mySiEAYaY2PXwWjQI/eEdqeY=;
        b=onppgC6JJBYBzWFyOmNgKBH1vmu1Cs42w8mqOWlcg+HN1bjcWX0c0tiQnzlFfJZngF
         JHW4oxp2ApoR4Z6UinzjT6yd5ILe9EH+IVtO+la5yBYRqn1Mw8ucFAHMs/+xtTgsnyIA
         NVpXAR2kJJ8mUo6gXEYZQOeapHsUGonOoUyZwbpHQ3EH5c8ZQegLql5WE9tvo34ENB2l
         UgNHgxvePNoYyxowE8Vea+zG2OQv4ArzgacsBs111wuzgljQNvPAtu+d/4IOiecK9ggb
         tO6sA2KTJ9zoJb5J+YfFi7ts8Ymx+OnRiIOhQKdin2cUn0M46EcRrXn91NViX+gBNKc/
         mcCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=W6pIMQuCx2FvcQCQIr+mySiEAYaY2PXwWjQI/eEdqeY=;
        b=V8G/hqTA+3gf2fpFqWHd6758unaT5H9XUzsR8avMgm8twMv89bDZERVYmJJzJPGKRK
         zdtDfIv2AjRK8Zd5nye4l/UbvvOO2AwVg7SKR4LY68PQxxcueqZhirJ8ke/wCfV6n9Lf
         B+ZeTocUURi/kjeIaHOqHTfnqnFJ0l7mI/yPPJuxE0e15C927vN7uvzvhFfKsYyUJ0A6
         QZdh/NaCtDORXtWZ/TmMAsQtDz/VVOCTOkzAaA/TX/gSghbiPzw2ixiMGI6GFEJqnplx
         CmUFn1pluzF9MW5Ean0LnOqPTmTFqRAT3d9pqugkcGI9MI99P51FwQvl6bXuK0Le007K
         ok9g==
X-Gm-Message-State: AOAM530e8NHgVBTFXfBhDVKOqZDOS+iMzgyKTPioSc1C4Ysm2IAqweHl
        UETlAMcKh2wtHS2ovj6u8rI=
X-Google-Smtp-Source: ABdhPJyIhph/lKVmx5fR9A1UfjyC6wlRBNYQp2lZNLQWdWoTpV1ZzRfkPhnY5dEiCEcLBfbm0Sicxw==
X-Received: by 2002:a05:6402:959:: with SMTP id h25mr28038748edz.287.1591139405175;
        Tue, 02 Jun 2020 16:10:05 -0700 (PDT)
Received: from ltop.local ([2a02:a03f:b7f9:7600:6c14:f667:d8de:40c1])
        by smtp.gmail.com with ESMTPSA id 64sm109524eda.85.2020.06.02.16.10.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jun 2020 16:10:03 -0700 (PDT)
Date:   Wed, 3 Jun 2020 01:10:00 +0200
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Jules Irenge <jbi.octave@gmail.com>, linux-kernel@vger.kernel.org,
        tglx@linutronix.de, paulmck@kernel.org, mingo@redhat.com,
        boqun.feng@gmail.com, Borislav Petkov <bp@alien8.de>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH 4/5] x86/ftrace: Add annotations for
 ftrace_arch_code_modify_prepare() and ftrace_arch_code_modify_post_process()
Message-ID: <20200602231000.6pfrgdgm4vd7sbvn@ltop.local>
References: <20200601184552.23128-1-jbi.octave@gmail.com>
 <20200601184552.23128-5-jbi.octave@gmail.com>
 <20200601154647.581fa345@oasis.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200601154647.581fa345@oasis.local.home>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 01, 2020 at 03:46:47PM -0400, Steven Rostedt wrote:
> On Mon,  1 Jun 2020 19:45:51 +0100
> Jules Irenge <jbi.octave@gmail.com> wrote:
> 
> > Sparse reports warnings
> > 
> > warning: context imbalance in ftrace_arch_code_modify_prepare()
> > 	- wrong count at exit
> > warning: context imbalance in ftrace_arch_code_modify_post_process()
> > 	- wrong count at exit
> > 
> > The root cause is that even if
> >  the annotations on the function are correct,
> > mutex do not support annotation

Yes.

> Wait what? This looks like either a bug in sparse, or we just remove the
> annotations. This just makes the code ugly, and looks silly.

The annotations added by commit
  074376ac0e1d ("ftrace/x86: Anotate text_mutex split between ...
are indeed wrong (because they don't match what the functions are
really doing / mutex operations have never been annotated).
The're also pointless since their prototypes are un-annotated.

-- Luc
