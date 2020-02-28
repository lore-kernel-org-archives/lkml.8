Return-Path: <SRS0=RI2K=4Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43CC0C3F2D2
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 19:01:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E0A22468E
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 19:01:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582916470;
	bh=pXSuRfzctrL6D0Q5MBEPmPUvSgYvyhQ5nxQeNe7l6x4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=uP+WtnA+lln8Bgcs+xmrkr4o2ZDoCgp9MnLyzIYvaZIwlmh2GB3fb9Nk8/IFeu3Ud
	 4GJrHo0/FHD/62HCKPfjJRQPDwysgfyvuQ1B0z/u2Tb2NqIGJMId7Wsjn2xInGnVNT
	 NGcVKQiJkhBalDHsozkMudhOGzuI50wAg7lr0A58=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726933AbgB1TBI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Feb 2020 14:01:08 -0500
Received: from mail.kernel.org ([198.145.29.99]:46070 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726621AbgB1TBF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Feb 2020 14:01:05 -0500
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2885F246B0
        for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2020 19:01:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582916465;
        bh=pXSuRfzctrL6D0Q5MBEPmPUvSgYvyhQ5nxQeNe7l6x4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=ToRNn3fVQk3Tf3sVY7FhwX9p5+qEWcnCgNk3lhjbf1YuwfJ/spion1RP78fV35zk+
         ATd9YgJ0XhqbvNz+HXLUq0P5v94SFQWk5jtBR2fvPoETIKlSJkI5V5X3X7bdrxomeR
         4++XuTZDSX4P3fqVygxqNUh1aGJ1qbD5k+7YQ14o=
Received: by mail-wr1-f53.google.com with SMTP id z15so4254904wrl.1
        for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2020 11:01:05 -0800 (PST)
X-Gm-Message-State: APjAAAVDh3y8//CYJ+HjeuXydsnNycZHJCVwFwBU3iwJXSqKPCPacwDO
        tX1egZQSy6tXndofnWSFJyeKCwahlx8Y3S+417revg==
X-Google-Smtp-Source: APXvYqyGnmD4L5HLlYq+yRQod51njh/dO0fO/Xp5Zr08pi3KDQjNyNHQfLcuatXiTDfiyzY56mJ3kaVAOmONa2f5raQ=
X-Received: by 2002:adf:df8f:: with SMTP id z15mr6002322wrl.184.1582916463562;
 Fri, 28 Feb 2020 11:01:03 -0800 (PST)
MIME-Version: 1.0
References: <20200227132826.195669-1-brgerst@gmail.com> <20200227132826.195669-7-brgerst@gmail.com>
In-Reply-To: <20200227132826.195669-7-brgerst@gmail.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Fri, 28 Feb 2020 11:00:52 -0800
X-Gmail-Original-Message-ID: <CALCETrW=R-tanwBwX9vCsnUiRdHooPq59uDVRBfwiOpC0MzRYQ@mail.gmail.com>
Message-ID: <CALCETrW=R-tanwBwX9vCsnUiRdHooPq59uDVRBfwiOpC0MzRYQ@mail.gmail.com>
Subject: Re: [PATCH v3 6/8] x86-32: Enable syscall wrappers
To:     Brian Gerst <brgerst@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Andy Lutomirski <luto@kernel.org>,
        Dominik Brodowski <linux@dominikbrodowski.net>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 27, 2020 at 5:28 AM Brian Gerst <brgerst@gmail.com> wrote:
>
> Enable pt_regs based syscalls for 32-bit.  This makes the 32-bit native
> kernel consistent with the 64-bit kernel, and improves the syscall
> interface by not needing to push all 6 potential arguments onto the stack.

Was the change to the table mechanically generated or mechanically
verified?  If so, how?

After this goes in, I should dust off my code to get rid of all the
__abi crud in the tables.  I never quite got it working well enough,
but your series should help.

--Andy
