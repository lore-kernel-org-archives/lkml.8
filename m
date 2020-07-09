Return-Path: <SRS0=8wH5=AU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C899C433E2
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 16:02:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 29D5A2077D
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 16:02:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594310539;
	bh=K45DJ14e/pHYHlhDRXMB06y45U/dqxzjDYmEbXO0t7Y=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=P1cfNDzlXjXHnGtXPcOV1YwkSBYaouTEQe9m8P8L/UpiC+d8+QWMGwsIwn+gzGbYi
	 MrzCoDJ8nMUtXwI3vNOZn+IwuZuimyAarxCzNtHQJhc148xw7soohTHmw4VCpP8xd/
	 QZbn1izf7miHvKIk+jOZn6M8N4OoSovKohtnihl4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728036AbgGIQCS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jul 2020 12:02:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:52774 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727865AbgGIQCR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jul 2020 12:02:17 -0400
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CEF53208C3
        for <linux-kernel@vger.kernel.org>; Thu,  9 Jul 2020 16:02:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594310537;
        bh=K45DJ14e/pHYHlhDRXMB06y45U/dqxzjDYmEbXO0t7Y=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Pf7UXbU5lI9fMgrjIppWAZNBiQBJ/ELPGJrwqbOK9P0wrNZbvFk/HlQd8hDDHBVDn
         mgfmVUHcng5qIeI+42c4TRsXfdOxCMAhCnMNiWPoxfzMU/nx+GwhNpHxKUbGZ6KMAL
         fUMiKYOWX6VmX4AOqQ1B7DApro0HpdFHj3K9QDDs=
Received: by mail-wr1-f52.google.com with SMTP id q5so2963002wru.6
        for <linux-kernel@vger.kernel.org>; Thu, 09 Jul 2020 09:02:16 -0700 (PDT)
X-Gm-Message-State: AOAM531uyDyXILun8C5+SEnkoSoJM4GGhQmhgwE6PcGsoq11xrkWj785
        Z5Or7uc7bdGSzuuzB+jzWc9xh3+fxd0LKomSoErPNw==
X-Google-Smtp-Source: ABdhPJxzRIFsc7By7VMCeEO3c+cA7oBIQu77SztDLFlUnbln1kuZgDgGF2rnT8p5T+DVTINyww/KaQgNkWN6aCLZjCI=
X-Received: by 2002:adf:f707:: with SMTP id r7mr63065788wrp.70.1594310533334;
 Thu, 09 Jul 2020 09:02:13 -0700 (PDT)
MIME-Version: 1.0
References: <20200709145447.549145421@hpe.com> <20200709145448.652996700@hpe.com>
In-Reply-To: <20200709145448.652996700@hpe.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Thu, 9 Jul 2020 09:02:01 -0700
X-Gmail-Original-Message-ID: <CALCETrXo9gTR0XWQ5e-YoRryyvJ3tuOaOVB+DyF5OUNRpfBteQ@mail.gmail.com>
Message-ID: <CALCETrXo9gTR0XWQ5e-YoRryyvJ3tuOaOVB+DyF5OUNRpfBteQ@mail.gmail.com>
Subject: Re: [patch v2 09/13] x86: Remove efi=old_map command line option
To:     steve.wahl@hpe.com
Cc:     Jonathan Corbet <corbet@lwn.net>, Ard Biesheuvel <ardb@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        X86 ML <x86@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Juergen Gross <jgross@suse.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Oliver Neukum <oneukum@suse.com>,
        Mike Travis <mike.travis@hpe.com>,
        Dimitri Sivanich <dimitri.sivanich@hpe.com>,
        Benjamin Thiel <b.thiel@posteo.de>,
        Andy Lutomirski <luto@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        James Morris <jmorris@namei.org>,
        David Howells <dhowells@redhat.com>,
        Kees Cook <keescook@chromium.org>,
        Dave Young <dyoung@redhat.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Alexandre Chartre <alexandre.chartre@oracle.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Austin Kim <austindh.kim@gmail.com>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-efi <linux-efi@vger.kernel.org>,
        Russ Anderson <rja@hpe.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 9, 2020 at 7:55 AM <steve.wahl@hpe.com> wrote:
>
> As a part of UV1 platform removal, delete the efi=old_map option,
> which should no longer be needed.

Can you also update kernel_parameters.txt?

--Andy
