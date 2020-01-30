Return-Path: <SRS0=4zup=3T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5C54C2D0DB
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jan 2020 15:27:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 99FA220707
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jan 2020 15:27:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1580398071;
	bh=n6HwRjDP3VCe5wjs8wEvgrTbWhzz9GyW+XTqLhafQxg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=fYcuYAyJBdRTWYNVO98dzUu165KkSzXOWb6ckWF7cI+8my6LeKzfCJFouTuro/mNE
	 NU6VkE5f5tpT/xroWQUNxaOgEzEKS6L9oZbnvVs23P3n/paW7Pwf2CQndbtEBWoOHk
	 rsF1MrU4Q20nfabpqKIWiTW9QTuqg6Z6+G8lvhg8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727415AbgA3P1u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Jan 2020 10:27:50 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:34643 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727186AbgA3P1u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jan 2020 10:27:50 -0500
Received: by mail-lj1-f193.google.com with SMTP id x7so3831204ljc.1
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jan 2020 07:27:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RIdIBH6X8LWl4t/9rSOLUTnHaD3MeTKBV/I/ltFZNME=;
        b=L8pXy3ZloQYZUId/kbDCDyZfbopAwPQ4xydN+TZuDjcwYCnezY4GEed2xl2w5YNxir
         WF3nDSLOCTxZIJ5KMI6sxAhtUVcx0cYA7RZKg6O/f0ReXbDbyfsK8k7n0sE0cvpPRVUi
         aTHxC3U/lV2yylCXPvfszJxX/kDV9duz2PW/g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RIdIBH6X8LWl4t/9rSOLUTnHaD3MeTKBV/I/ltFZNME=;
        b=kjuYDOiGtMQNOeRyxmAiccnXmJmI31szSTBpUXxlTdY2G3uI8yvjxzhXUULa8kanWz
         FGs+eqzHol/IZ7vKux0/5phyix+7uTvvKCj8T4KWtI7em9bhuDgJwOKgwGmACDGcOA0A
         lkxTuL/kraNEu5D6gZ1QwcM/mKTQeClXT1ug8CdZitQyhIY6fJmX/rvv0QIUGH1z+QbE
         vaXLkSarNrUTKBNcjAhBDPOR8bj2oUCEfrw+2RJPWVSQx3OA5iFX3UC1irrxciGNitgn
         JId/BuXd01HIFSKNq6nqVzMnRAUYwiHX+JspPdvkWv7qI71lu91rQd5OMHsc22TRh1PM
         y4nw==
X-Gm-Message-State: APjAAAVeuojpZZRDQW9prjir0tufFXcizTlkWn/rHvl9NMgix059HPQh
        OPkReHotXT2n8+oqiBHPPKReuSb8SKw=
X-Google-Smtp-Source: APXvYqz1DGzla0nvh36CjiF3PB+v6WHmmbNSOoWrSdQ+H3ITXF3NBjagJZcmd/m3RFyze5szEw53Qg==
X-Received: by 2002:a2e:b5ce:: with SMTP id g14mr2986390ljn.264.1580398066929;
        Thu, 30 Jan 2020 07:27:46 -0800 (PST)
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com. [209.85.208.170])
        by smtp.gmail.com with ESMTPSA id i20sm2978104lfl.79.2020.01.30.07.27.45
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Jan 2020 07:27:45 -0800 (PST)
Received: by mail-lj1-f170.google.com with SMTP id r19so3814808ljg.3
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jan 2020 07:27:45 -0800 (PST)
X-Received: by 2002:a2e:9d92:: with SMTP id c18mr3307956ljj.265.1580398065073;
 Thu, 30 Jan 2020 07:27:45 -0800 (PST)
MIME-Version: 1.0
References: <20200128165906.GA67781@gmail.com> <CAHk-=wgm+2ac4nnprPST6CnehHXScth=A7-ayrNyhydNC+xG-g@mail.gmail.com>
 <CAHk-=wi=otQxzhLAofWEvULLMk2X3G3zcWfUWz7e1CFz+xYs2Q@mail.gmail.com>
 <20200129132618.GA30979@zn.tnic> <20200129170725.GA21265@agluck-desk2.amr.corp.intel.com>
 <CAHk-=wgns2Tvph77XZWN=r_qAtUwxrTzDXNffi8nGKz1mLZNHw@mail.gmail.com>
 <20200129183404.GB30979@zn.tnic> <CAHk-=wh62anGKKEeey8ubD+-+3qSv059z7zSWZ4J=CoaOo4j_A@mail.gmail.com>
 <20200130085134.GB6684@zn.tnic>
In-Reply-To: <20200130085134.GB6684@zn.tnic>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 30 Jan 2020 07:27:28 -0800
X-Gmail-Original-Message-ID: <CAHk-=wje_k92K6j0-=HH4F5Jmr8Fv7vB-ANObqbQeGS_RsikWA@mail.gmail.com>
Message-ID: <CAHk-=wje_k92K6j0-=HH4F5Jmr8Fv7vB-ANObqbQeGS_RsikWA@mail.gmail.com>
Subject: Re: [GIT PULL] x86/asm changes for v5.6
To:     Borislav Petkov <bp@suse.de>
Cc:     "Luck, Tony" <tony.luck@intel.com>, Ingo Molnar <mingo@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 30, 2020 at 12:51 AM Borislav Petkov <bp@suse.de> wrote:
>
> However, this new version has hit another shortcoming of the
> alternatives - check this out:

[ Branches not getting fixed up ]

Fair enough. Let's not complicate things just to avoid a few nops.

That does make me wonder about RIP-relative addressing in alternatives
too. Particularly anything where we let gcc pick addressing modes. I
guess we don't have any, but maybe this branch issue and possible RIP
addressing is something that objtool could be taught to warn about?

                  Linus
