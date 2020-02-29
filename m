Return-Path: <SRS0=iO2y=4R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CCC7C3F2C6
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Feb 2020 18:33:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA0B224677
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Feb 2020 18:33:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Pv97Pxv7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727553AbgB2Sd1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Feb 2020 13:33:27 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:33552 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727274AbgB2Sd1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Feb 2020 13:33:27 -0500
Received: by mail-lj1-f194.google.com with SMTP id y6so7085728lji.0
        for <linux-kernel@vger.kernel.org>; Sat, 29 Feb 2020 10:33:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=J0QUgzZ4WkYGkcRzl+slh7S/9xKhHLAbeIDFRLeX4rY=;
        b=Pv97Pxv7b0wU24jRqR7G5YZY9n7APjj/ALQ0caAR8Id0ktGWCsHqyGFZSeA/LEdfFf
         iDCHTWuZ1WbLL9I4uSLaRgXcjiZA7cDOhmAHiAzEeiOT8S7hJjAWmDSCXEZTtxP994x2
         OPkkRsAgjae6w3YWRKvH+CeSbsJyCde7zx9/FR5qbYJ4R6rFyjVxNewl8BAXWJ3pJLJ8
         rQtFdml4SigigKM/eAG2tEbVglD32SraR7GlDPKd31DE42SD9L25jP4a1Lsshl2xuRYP
         vKD9joU/IWNwS19M6od5S3XeeydZiNxrxDQKWrc0CMs5QPPY3H9ZA4nt64xZiT2WoxHJ
         og6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=J0QUgzZ4WkYGkcRzl+slh7S/9xKhHLAbeIDFRLeX4rY=;
        b=nrJ7MVnpmriSoP3mfXNHIdv8fs+CwQxPa2kynfz/ePGFoXLSqWoMRHhwlH/UJCmh2+
         NTwOVv+8sbCH2+JN7tr+oQBfgqfgzILRHjLLKCYBx2gUU+aS1z/bB6EHoiFhv9d2+lCq
         7xavhq79Zsaxh6hVsQioALOn/no8LMnCykfFID49ER1gV3yY4a2lG6MqAnGE4KLfa3/3
         dDVS954Zuku/cEHnU3L9bwZM+IhTOYnvOV+0M/7s5QWz7jNKSGcUyU8Ly0T6ay9RnsUE
         XltqKRDvkTnVmWLO8A23v2mGKXwQ6lQ732+rsbj56ktg8NtyDE9gol9bGJEd5R8FGvED
         q3QQ==
X-Gm-Message-State: ANhLgQ18e5oaoL+M+9LGtmsbjTcLAOQtDNrDejkejjbCVZRY0AjG+dZ6
        PwafqoVVGlpaC6yY9a9Z6ehOHVSuBQhdgSB93FbxJA==
X-Google-Smtp-Source: ADFU+vtSviI3qlY7iSQKY0tYuP5O6rDtodZyvgxGWul1aApy5++Pdps2sONbzNDv2OmtBRGkjQOImS5ZTyGBxCEfcHU=
X-Received: by 2002:a2e:3608:: with SMTP id d8mr6575052lja.152.1583001203709;
 Sat, 29 Feb 2020 10:33:23 -0800 (PST)
MIME-Version: 1.0
References: <1582570596-45387-1-git-send-email-pbonzini@redhat.com>
 <1582570596-45387-2-git-send-email-pbonzini@redhat.com> <41d80479-7dbc-d912-ff0e-acd48746de0f@web.de>
In-Reply-To: <41d80479-7dbc-d912-ff0e-acd48746de0f@web.de>
From:   Oliver Upton <oupton@google.com>
Date:   Sat, 29 Feb 2020 10:33:12 -0800
Message-ID: <CAOQ_QshE7SMX2cO7H+21Fkdpg53oE2D3xrHPJHR_MCfH4r9QCQ@mail.gmail.com>
Subject: Re: [FYI PATCH 1/3] KVM: nVMX: Don't emulate instructions in guest mode
To:     Jan Kiszka <jan.kiszka@web.de>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        kvm list <kvm@vger.kernel.org>, stable@vger.kernel.org,
        Jim Mattson <jmattson@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jan,

On Sat, Feb 29, 2020 at 10:00 AM Jan Kiszka <jan.kiszka@web.de> wrote:
> Is this expected to cause regressions on less common workloads?
> Jailhouse as L1 now fails when Linux as L2 tries to boot a CPU: L2-Linux
> gets a triple fault on load_current_idt() in start_secondary(). Only
> bisected so far, didn't debug further.

I'm guessing that Jailhouse doesn't use 'descriptor table exiting', so
when KVM gets the corresponding exit from L2 the emulation burden is
on L0. We now refuse the emulation, which kicks a #UD back to L2. I
can get a patch out quickly to address this case (like the PIO exiting
one that came in this series) but the eventual solution is to map
emulator intercept checks into VM-exits + call into the
nested_vmx_exit_reflected() plumbing.

--
Thanks,
Oliver
