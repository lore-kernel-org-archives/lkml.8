Return-Path: <SRS0=xNW4=3S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,URIBL_DBL_ABUSE_MALW autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33389C33CB7
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jan 2020 13:52:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 076222082E
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jan 2020 13:52:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="OA+jLaOx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726736AbgA2NwH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Jan 2020 08:52:07 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:45655 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726605AbgA2NwG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jan 2020 08:52:06 -0500
Received: by mail-ed1-f65.google.com with SMTP id v28so18641893edw.12
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jan 2020 05:52:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=g/z/wuxc+7xT2yV/Klj0Qifjo3UGoZMxK1efiAVi90k=;
        b=OA+jLaOxwv5kxEK2jsC84DNaLbn6Q1JxahmQrobXYSjuoltN+RtJtJ4ZtScgLiCFu3
         T5UYzEfynULE4EaZg4NBya6auTieKqJkB2N44rpxTyRYKKTCiGSN3sfgKbWAjKWTZZgk
         bAD8Oj8cd64yGmTYuHWo3WiQieUFsd3dneI8ES7qmXhnxxYMoRE/LfryOQtanjRzfZkC
         hKKe/5J/uYyUdKpTYVjyKNMTSptlQBaj2dAw2epcloBiAsIge+mEKsRomG6oAnqwGVMe
         3NY7D1MfljKmmnH8QiCR5CwQaU5BXX/6xWOJPMIlDcDhlRKQTQTuG2EXA+XQ0hioW122
         +fAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=g/z/wuxc+7xT2yV/Klj0Qifjo3UGoZMxK1efiAVi90k=;
        b=nikRXiOOAh5OhHmLxkumqxD0NFuUlLugYKxdmoTzP7uRt+RfWA3Z5UopqXhD2h+fD3
         bL+mZEkr0todQI1EybZkRcAChGbeyGZVgkFZY5STPyQTjLkSCzTrj4kWLlpVCY2rrJMN
         b1DLp20twvRb5xHlDlcF0ZkAbv6uFdS3/iEq0s6H/jBUNcVCITZYwUZYArW5Rv+w7m+7
         jtVKAsn7JprZtG+vufQdESnujiForP7MJyXZiFTZ5ATroFvPW38EiuHZmKkAf9Pt6JoQ
         XOxgYcP/E/G+LQBKUZOSaym3IcxbXi2E2nJX0wN2xzB40SEiircDKSjf3/XuUANMoycf
         CyKg==
X-Gm-Message-State: APjAAAWBdrg37dFbih4oTAnoc+1UUYHjKST3wvUYp9Me1UONBlTdiHc9
        3FSY/SiH0xcTM24dXZjA7aavTIqybvncG5is6AYg
X-Google-Smtp-Source: APXvYqzfpqAQqbk304DWn4ktRIxY8tzK9qnQQq5mo7EYBxsHQtxhRehkW3/mP7Fefk8Y240fGdoIbbYINrSyMgy7Rl0=
X-Received: by 2002:a17:906:f251:: with SMTP id gy17mr7400826ejb.308.1580305924909;
 Wed, 29 Jan 2020 05:52:04 -0800 (PST)
MIME-Version: 1.0
References: <20200129040640.6PNuz0vcp%akpm@linux-foundation.org> <56177bc4-441d-36f4-fe73-4e86edf02899@infradead.org>
In-Reply-To: <56177bc4-441d-36f4-fe73-4e86edf02899@infradead.org>
From:   Paul Moore <paul@paul-moore.com>
Date:   Wed, 29 Jan 2020 08:51:53 -0500
Message-ID: <CAHC9VhRW68ccE_8HJnv4anFdSgkY2Yk3612LPCT5o4+vXQGqQA@mail.gmail.com>
Subject: Re: mmotm 2020-01-28-20-05 uploaded (security/security.c)
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     akpm@linux-foundation.org, broonie@kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-next@vger.kernel.org, mhocko@suse.cz,
        mm-commits@vger.kernel.org, sfr@canb.auug.org.au,
        linux-security-module <linux-security-module@vger.kernel.org>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 28, 2020 at 11:52 PM Randy Dunlap <rdunlap@infradead.org> wrote:
> On 1/28/20 8:06 PM, akpm@linux-foundation.org wrote:
> > The mm-of-the-moment snapshot 2020-01-28-20-05 has been uploaded to
> >
> >    http://www.ozlabs.org/~akpm/mmotm/
> >
> > mmotm-readme.txt says
> >
> > README for mm-of-the-moment:
> >
> > http://www.ozlabs.org/~akpm/mmotm/
> >
> > This is a snapshot of my -mm patch queue.  Uploaded at random hopefully
> > more than once a week.
> >
>
> security/security.c contains duplicate lines for <lockdown_reasons> array:

Hmmm.  Commit 59438b46471a ("security,lockdown,selinux: implement
SELinux lockdown"), which was merged into Linus' tree during the
current merge window, moved the lockdown_reasons array from
security/lockdown/lockdown.c to security/security.c; is there another
tree in linux-next which is moving lockdown_reasons into
security/security.c?

-- 
paul moore
www.paul-moore.com
