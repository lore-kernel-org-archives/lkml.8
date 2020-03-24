Return-Path: <SRS0=tn8d=5J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1ABAC43331
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 19:59:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B7322074D
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 19:59:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qYdy9ZyB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727659AbgCXT7G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Mar 2020 15:59:06 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:32777 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727088AbgCXT7G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Mar 2020 15:59:06 -0400
Received: by mail-pl1-f195.google.com with SMTP id g18so7876604plq.0
        for <linux-kernel@vger.kernel.org>; Tue, 24 Mar 2020 12:59:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gcQRcAtEQg4rjglKJRL2d98Lwfwnni+3VOu5y4qk85w=;
        b=qYdy9ZyBm+V84vQRBdlRTTvNTWSlZa5gYHUIUgd4O4BL5QBdn6VF9+ymfZWyvKzL/2
         /FOM9/+eBM3zVmgxj6CLruwd+vCZ5F8v6fKWp+ANxQUv9ZKTrG9WXB6KVw+xf15tRh/M
         bEZpa2mn4ETx1ELJqqGcVJ56DtgBO8mwIYIbKSpeB8ThQwmMHDppJVerNjKNcjMNfIdn
         4mwR48QTj83kunUhPaEhiY4GG8YIcPxsA/2jWrps7vuIhcEX84DwnB9kQ+DijcW6QF2d
         HPMyPCpZURVGe/yMfvl4PiIqZnOO4Ujrk2RxJrGbIuD4IctdsbBG3/lOTk27h7IopctE
         5VdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gcQRcAtEQg4rjglKJRL2d98Lwfwnni+3VOu5y4qk85w=;
        b=DE1HHVx88MfXMOis2Mwe0ODeEryZILx1WC5zSiBhKDjSY1fYXQgoA3WbNkTXk8LLeQ
         zFxS/F4c/3Eoxr1DyI3k8kw1owKGnBmWOmhpMuLIUgcwHnVYohc+gs5PSC6Qcd5apkG7
         snzGqK+TOP9rj+ldlc8Hoshw8aiTHLg92+ql4mVodJPhdE39DVskIBnBRALENwbXeXr5
         ys3xCCBAqOgKXdrNvQnoLx6/PUF3q9O4lYVNT2MPhvNRdW6xbx2GA17B/kKE6r/hrIkp
         mDr0nIIQzROr/mDTGkE5P55WZcyA3HwPzICP8WsofhO1S4/UXmrAm4boM7l1V67T4HZ5
         juRw==
X-Gm-Message-State: ANhLgQ0PB2V0UL6JdN1UopNDiwVy8dzZhcOxi+mkkDOPVAXLsGD7Why4
        l0DeOYywszkuuYB+I5+/b2hzeE8/4AkjjsFRvPpqWw==
X-Google-Smtp-Source: ADFU+vuilu4nK+FQYgpHdIaviKzEUBXNJjUU1ornx3/tJ+r2le+vN0Nlu7KwhPe37OGsZLY9Z8pKyFJL8kFUhNhEyA8=
X-Received: by 2002:a17:902:6bc8:: with SMTP id m8mr21730233plt.223.1585079945020;
 Tue, 24 Mar 2020 12:59:05 -0700 (PDT)
MIME-Version: 1.0
References: <20200324161539.7538-1-masahiroy@kernel.org> <20200324161539.7538-3-masahiroy@kernel.org>
 <CAKwvOdkjiyyt8Ju2j2O4cm1sB34rb_FTgjCRzEiXM6KL4muO_w@mail.gmail.com>
In-Reply-To: <CAKwvOdkjiyyt8Ju2j2O4cm1sB34rb_FTgjCRzEiXM6KL4muO_w@mail.gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Tue, 24 Mar 2020 12:58:54 -0700
Message-ID: <CAKwvOdmWqAUhL5DRg9oQPXzFtogK-0Q-VZ=FWf=Cjm-RJgR4sw@mail.gmail.com>
Subject: Re: [PATCH 3/3] kbuild: remove AS variable
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        "David S . Miller" <davem@davemloft.net>,
        Network Development <netdev@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 24, 2020 at 12:38 PM Nick Desaulniers
<ndesaulniers@google.com> wrote:
> consistent in this regard (and not using the compiler as the driver),

Ah, the preprocessor; we need to preprocess the .S files, .s files are
fine (though we have .lds.S files that are not `-x
assembler-with-cpp`)

-- 
Thanks,
~Nick Desaulniers
