Return-Path: <SRS0=BsgQ=65=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B4E6C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 05:25:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D52DA206F1
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 05:25:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589520347;
	bh=jkC+6grw0Xb6y7mrrbxbff/lYlWdmY3NyQrQQ0x8tko=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=NUg6gYE4LgPczciDAo46+Q3MtO0cAna3pr+uUe9Bza6QVo37Nk960u4bA2IBY5UnS
	 56ljHJCFcasaKoL1OgENVK81/QCFjvb+O8RslGtZk7np3sATWG1p1mdKyXLDUibIzs
	 BJ7SdMdeJTqKvUUDB8LbIwAfZ6Chb51wzFdXXmY0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726461AbgEOFZr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 May 2020 01:25:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:33884 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726139AbgEOFZq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 May 2020 01:25:46 -0400
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DB0B5206F1
        for <linux-kernel@vger.kernel.org>; Fri, 15 May 2020 05:25:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589520346;
        bh=jkC+6grw0Xb6y7mrrbxbff/lYlWdmY3NyQrQQ0x8tko=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=uGHJKeSCesxjBWZwHRcDTb5IuLKU7E5VkuSxGhxiCN/UolfpfEMDHPMmo+s7nKj0l
         RQV8qd7KO+xV+Q4n+oCX4ZPpS8pVVFnk49fJt6a5/Iv0wV85u2woB3uTh5NWB+GT11
         aomXygxcSys4+k/olBK+/Z7OJCFSIHqtaneBaInE=
Received: by mail-wm1-f47.google.com with SMTP id f134so933227wmf.1
        for <linux-kernel@vger.kernel.org>; Thu, 14 May 2020 22:25:45 -0700 (PDT)
X-Gm-Message-State: AOAM53105M+mmz42vwqxauCRT3QGx+MZWqXjQC4rjm5yZ+eywaJuBkaV
        EcCdWHQtUZEPHd8zN/3GGji9P5WYQL2PQvpg1mPBng==
X-Google-Smtp-Source: ABdhPJz23w97d8vSG9PZ3lyzo9DWo5X07tm4ohOe+BXqc49jA1L6wgu+SfyVRyNPdjaJyvvd7+Q0lA0B2Hla6yQ3B8Y=
X-Received: by 2002:a1c:b3c1:: with SMTP id c184mr1927530wmf.36.1589520344402;
 Thu, 14 May 2020 22:25:44 -0700 (PDT)
MIME-Version: 1.0
References: <20200505134926.578885807@linutronix.de> <20200505135314.518622698@linutronix.de>
In-Reply-To: <20200505135314.518622698@linutronix.de>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Thu, 14 May 2020 22:25:32 -0700
X-Gmail-Original-Message-ID: <CALCETrX9B=0+MyrJyvGDW40O0VRDPPLBAuiH-Om8YaV4nhOMNg@mail.gmail.com>
Message-ID: <CALCETrX9B=0+MyrJyvGDW40O0VRDPPLBAuiH-Om8YaV4nhOMNg@mail.gmail.com>
Subject: Re: [patch V4 part 4 12/24] x86/idtentry: Provide IDTENTRY_XEN for XEN/PV
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Alexandre Chartre <alexandre.chartre@oracle.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>,
        Brian Gerst <brgerst@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Will Deacon <will@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 5, 2020 at 7:16 AM Thomas Gleixner <tglx@linutronix.de> wrote:
>
> XEN/PV has special wrappers for NMI and DB exceptions. They redirect these
> exceptions through regular IDTENTRY points. Provide the necessary IDTENTRY
> macros to make this work


Acked-by: Andy Lutomirski <luto@kernel.org>
