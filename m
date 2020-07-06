Return-Path: <SRS0=eGSO=AR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11839C433E0
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 11:15:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DDCAA2073E
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 11:15:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Uyc7LAqj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728880AbgGFLPo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jul 2020 07:15:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728578AbgGFLPn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jul 2020 07:15:43 -0400
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81948C061794
        for <linux-kernel@vger.kernel.org>; Mon,  6 Jul 2020 04:15:43 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id w16so41909820ejj.5
        for <linux-kernel@vger.kernel.org>; Mon, 06 Jul 2020 04:15:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=cc:subject:to:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=OyfaboQiLD7e60Rt0fpF2g5A7vePJGkRXKorLr5zFEw=;
        b=Uyc7LAqj/fGeUowhfHf3Zh7ykH1nK9ZzLsVFlmMsOwTy/b7WhE2yLMKtIg+UsXdWmw
         Lk5Y/x9fp9gIUmQDoy083MUEGZv0+84b2V44Qe654U9g7apPddmh5xaB+NkiZ6CMD3lw
         RhRZl1KzDxC/vALP2lMU6+JEC/550g02B0HlfZ/yaDkYWn5itmd3KPlZ32oTQuOthgsg
         nDBoKlhR1ek526WlxY6Z+UgUnxD4PVTTJUEwmonngmXV0eeUWWU9HEVs6qKkts3Se8FG
         2I4mUQP93DlWLwoMIHjaZjXObLaCR4cgMdN9zTh/QTM/zXS/e/7QDDQu35b0T4sDJNK6
         yEGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:cc:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=OyfaboQiLD7e60Rt0fpF2g5A7vePJGkRXKorLr5zFEw=;
        b=C6mAlWasKtbureJJpBVSh42bzGCsB2jit7HLRTwGjD6vDvmnCVIwlZBERTjCNkqDW3
         rNYvuwBOLtwFHFiK1RRDeivjlI9ni4s+Az3vNkFGIrcqVmmYLfUcNhhwvGVSQYt9cpBC
         4vJdZQT7rhVvxRxbqkvVZOUbO2Yo1ijHhNKWkDTbJGvTQF64RwsGGzM9+lUuHewrrkO/
         NhbVWX9wEOvAjuzmitiA0c5TuNzQC177mW8gmZ+Ri27unAoJaTbrTxVvScayuKaWWtDn
         EuE2G/y8cgjHKKl6/59Vsih+JdSoJqHpBP6uIyZVPa8wHtAXe9yjr1fIw1PcHvlMyXq+
         j3rQ==
X-Gm-Message-State: AOAM532ZKIFut1kpRVexMeT+hWVorjiv7ezZZwx6pEnLSjDk9GaLoPO7
        R896B6voeeg17mkKHICpIVY=
X-Google-Smtp-Source: ABdhPJw94tFJtTSl2W6ES4QpwV4udsVsb5UYSoR/ZLQz/kL9wfqqXK1RfjTuif6Y6mo+rSyLBe2w8A==
X-Received: by 2002:a17:906:958f:: with SMTP id r15mr31228363ejx.77.1594034142283;
        Mon, 06 Jul 2020 04:15:42 -0700 (PDT)
Received: from ?IPv6:2001:a61:3adb:8201:9649:88f:51f8:6a21? ([2001:a61:3adb:8201:9649:88f:51f8:6a21])
        by smtp.gmail.com with ESMTPSA id s1sm23168755edy.1.2020.07.06.04.15.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Jul 2020 04:15:41 -0700 (PDT)
Cc:     mtk.manpages@gmail.com,
        ksummit <ksummit-discuss@lists.linuxfoundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        tech-board-discuss@lists.linuxfoundation.org,
        Chris Mason <clm@fb.clm>, expensivestephen@hotmail.com
Subject: Re: [Ksummit-discuss] [Tech-board-discuss] [PATCH] CodingStyle:
 Inclusive Terminology
To:     Kees Cook <keescook@chromium.org>,
        Matthew Wilcox <willy6545@gmail.com>
References: <159389297140.2210796.13590142254668787525.stgit@dwillia2-desk3.amr.corp.intel.com>
 <920e6dc0-628b-9bad-926a-d1238a373cda@infradead.org>
 <CAPM=9ty0tiL_qM_UFv0S0VtARKz_f-Anngc+amDM5LjGAHazhA@mail.gmail.com>
 <CAFhKne9MA_G-UsvBFfX-gZRcu9Gb7Xt7UxQ14MTppdU3X1VYdQ@mail.gmail.com>
 <202007041804.B5E229E2B6@keescook>
From:   "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>
Message-ID: <8c0c1050-3beb-86f6-f184-4687acffd61d@gmail.com>
Date:   Mon, 6 Jul 2020 13:15:38 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <202007041804.B5E229E2B6@keescook>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/5/20 3:10 AM, Kees Cook wrote:
> On Sat, Jul 04, 2020 at 08:10:33PM -0400, Matthew Wilcox wrote:
>> Left-right tree makes no sense. It doesn't distinguish the rbtree from its
>> predecessor the avl tree.  I don't think it's helpful to rename a standard
>> piece of computing terminology unless it's actually hurting us to have it.
>> Obviously if it were called a "master-slave" tree, I would be in favour of
>> renaming it.
> 
> (No one has suggested renaming red/black trees, so I think the
> slippery-slope argument can be set aside here.)
> 
> As for the actual proposal on white/black-list, I've always been annoyed
> by the poor description it provides (and I get to see it A LOT being
> the seccomp maintainer). I welcome allow/deny-list (though the change is
> not new for seccomp -- the man pages were updated last year (thanks
> mkerrisk). :)

Actually, the manual pages are ahead of the game only thanks to
a nice presentation last year @OSS from Stephen Kenigbolo :-).


-- 
Michael Kerrisk
Linux man-pages maintainer; http://www.kernel.org/doc/man-pages/
Linux/UNIX System Programming Training: http://man7.org/training/
