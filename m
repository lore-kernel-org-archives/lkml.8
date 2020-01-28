Return-Path: <SRS0=OrIQ=3R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B891DC33CB3
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 09:30:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7CB622467B
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 09:30:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VzGyPT+y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725948AbgA1Jas (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jan 2020 04:30:48 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:45760 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725271AbgA1Jas (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jan 2020 04:30:48 -0500
Received: by mail-ot1-f67.google.com with SMTP id 59so11329578otp.12
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jan 2020 01:30:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yh41YjQOL6v5qPkhPRLG/JO3Fw/88a695J6NKkJZrX0=;
        b=VzGyPT+yQnMZWoX1YeBN9u8Fx5p+Am8kWrm005R45IP8atXD3C+oTdtHxSOA5v9BRE
         3Nig17W/n+ysFLzSZAFhSx3yjCeq+JLnmIcBu3dJ8nsNKx/4Q/bYUFTUbDjmze6metaP
         Hy3VRvHtnNsmHjt8W/xS4mDccKPlw8UL4hwQmxuQ9DzABpDaJE7b3DR9Jd1v58JmVsv0
         MVNYjHw494rtK0iFkHcOGuIPm6dyRgOvqti7c5R/MbBVHMaBNSSwoscjG2dlDlnKGPgN
         vLy4PB4tKkgZ3053449rUXz2ZNMb53RTi2tkML4hNLrxnFwbpBW75aMMsRkM+v+X0Y+A
         36mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yh41YjQOL6v5qPkhPRLG/JO3Fw/88a695J6NKkJZrX0=;
        b=RNIyhk18bYYvVRk2Cs6mf73yqZyuU5NzHvRBcj9AhmLNgjfFCGZ7OeOvia5I95dHRx
         kAYA0QnPrByW7lsLLu3wBiDh3bFWrHXtP4VGN7hUMOlPIdpuvA5YRNNz1P1nB8u5kRzM
         QaR4NDFBo8lhXEmF4ZV2r6cHuJg2crahkydi3+xbVRKNcS/ywZewPaSCd0rvvj++Wv0J
         0f+yd8+7WkJSk/KPyYxH+ARYh2avrK+dEFi5qHMZ3WVImLoaDjPCc/UUIAuAabFzbgIB
         dRex/oTJ3ZkKRXyYQOkz6SAeytwJmhGfj8kCIIh3hJs+ixO5Oeeg6PFHexG98o3u4swA
         VA4g==
X-Gm-Message-State: APjAAAUM5b4OHtoLbeX0FWWMiRdotR9C+nCXRX4IlPKR9dnlwus12lkK
        bSleQOsfgXkmRN6dA5JXDLKmFYqjvw2tD8/gza+cyQ==
X-Google-Smtp-Source: APXvYqymR8w/Jv0Wq2tNhPnRAIsBKyqe0PLz5bMDnxBePf0GK0M2eqKuON/UlhLLm577QR6m4J2QrKzRKeI22A+nyXA=
X-Received: by 2002:a05:6830:1d6e:: with SMTP id l14mr15362244oti.32.1580203847077;
 Tue, 28 Jan 2020 01:30:47 -0800 (PST)
MIME-Version: 1.0
References: <20200128072740.21272-1-frextrite@gmail.com>
In-Reply-To: <20200128072740.21272-1-frextrite@gmail.com>
From:   Jann Horn <jannh@google.com>
Date:   Tue, 28 Jan 2020 10:30:19 +0100
Message-ID: <CAG48ez3ZcO+kVPJVG6XpCPyGUKF2o4UJ6AVdgZXGQ6XJJpcdmg@mail.gmail.com>
Subject: Re: [PATCH] cred: Use RCU primitives to access RCU pointers
To:     Amol Grover <frextrite@gmail.com>
Cc:     David Howells <dhowells@redhat.com>,
        Shakeel Butt <shakeelb@google.com>,
        James Morris <jamorris@linux.microsoft.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Kees Cook <keescook@chromium.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        kernel list <linux-kernel@vger.kernel.org>,
        linux-kernel-mentees@lists.linuxfoundation.org,
        Joel Fernandes <joel@joelfernandes.org>,
        Madhuparna Bhowmik <madhuparnabhowmik04@gmail.com>,
        "Paul E . McKenney" <paulmck@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 28, 2020 at 8:28 AM Amol Grover <frextrite@gmail.com> wrote:
> task_struct.cred and task_struct.real_cred are annotated by __rcu,

task_struct.cred doesn't actually have RCU semantics though, see
commit d7852fbd0f0423937fa287a598bfde188bb68c22. For task_struct.cred,
it would probably be more correct to remove the __rcu annotation?

> hence use rcu_access_pointer to access them.
