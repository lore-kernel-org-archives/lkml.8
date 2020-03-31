Return-Path: <SRS0=6o4L=5Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0B7AC43331
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 18:20:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8940121473
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 18:20:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585678859;
	bh=bVzVLbJpXjT5F8t9zyWMDDK2MOmP4AH52KrfSudbEZc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=zj4RgGYqUVoJTde5W6AqtfII/Ch25C6KucaZiERQeyS7x2phbtq43cW9ffqYw6y2/
	 M0ejkzS8TnFp3Sb745X4/Mkh9jjLgzWwFur7iTGYzCc9dziTxGfTk+zznL1mqml5GV
	 webzs4BVv+026vlAwAQlxC+vWKyvzRLSa2K4jY6o=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726402AbgCaSU6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Mar 2020 14:20:58 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:35526 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726000AbgCaSU6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Mar 2020 14:20:58 -0400
Received: by mail-lj1-f195.google.com with SMTP id k21so23085900ljh.2
        for <linux-kernel@vger.kernel.org>; Tue, 31 Mar 2020 11:20:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uoULL4HJ/4Fp45aaQk4Hu/7pgyNJbne+Y7btBWjm98M=;
        b=CmzsV6h6bpJpOjdOqIiordG7PqBedgrJWUslQaSWFFc0PsAmoW2n9Qmm4fjP+rxipj
         KTlpTC0p6VP22xW/i/jVMikS9NwXnvvz/JiCG+nYjMhKP6k73ZUMogsKMud7bMuFkBpY
         nQrxqOrO+CKYfRRzCAFGQ+yAFURIBGhmcQJZM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uoULL4HJ/4Fp45aaQk4Hu/7pgyNJbne+Y7btBWjm98M=;
        b=UNLoc38tMmWRWIV+mC6H7PxRCncXPyoTSFN2Gk/s7OnAz4n8QSJcBPqDUo1hG8wlY9
         s0qicL96DLYE+YOsInuhEmnW9btoh+7CTyR2b0Jvx/nBkffB9KPjyIuZ2f5axuwiiNL7
         7f3NRlvxQ5rxmFSgTu3HvGTB3/m7YQZ4n/Z5Au+wzfXzG130yXiA8py5TgrGgpMEEC2g
         2PIaTxYyQ98+QAq/4Oi0/XzN8c8LBio5wqbFw4gaW+wLcjs45kcINGf322EKCHHlgxdd
         c24Fj+I95w/4LqerVBqIcaKByoMzpuJKTCbAQEmjqOrLe71SCj4Z7HLZx8kd/iAPSTPm
         ukUw==
X-Gm-Message-State: AGi0Pua9J6PyRWa/cCS7kncndc6S/R7F8lIajl+IQKBmMVzbzfmO8PR4
        Z3NL006nAWPy3vGsbvi/XVCDAYDJ2sw=
X-Google-Smtp-Source: APiQypKs2XyH3w24wbpfSlg9nw2StL4cRW9VN5u5eVO7hTwoC98IdlZ3g8YeR32x8/wHwTgTARTHjQ==
X-Received: by 2002:a2e:8693:: with SMTP id l19mr11603781lji.132.1585678855821;
        Tue, 31 Mar 2020 11:20:55 -0700 (PDT)
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com. [209.85.208.177])
        by smtp.gmail.com with ESMTPSA id b193sm10299397lfd.74.2020.03.31.11.20.54
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 31 Mar 2020 11:20:54 -0700 (PDT)
Received: by mail-lj1-f177.google.com with SMTP id q19so22982534ljp.9
        for <linux-kernel@vger.kernel.org>; Tue, 31 Mar 2020 11:20:54 -0700 (PDT)
X-Received: by 2002:a2e:b4cb:: with SMTP id r11mr11392287ljm.201.1585678853923;
 Tue, 31 Mar 2020 11:20:53 -0700 (PDT)
MIME-Version: 1.0
References: <20200331085308.098696461@linuxfoundation.org> <CA+G9fYsZjmf34pQT1DeLN_DDwvxCWEkbzBfF0q2VERHb25dfZQ@mail.gmail.com>
In-Reply-To: <CA+G9fYsZjmf34pQT1DeLN_DDwvxCWEkbzBfF0q2VERHb25dfZQ@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 31 Mar 2020 11:20:37 -0700
X-Gmail-Original-Message-ID: <CAHk-=whyW9TXfYxyxUW6hP9e0A=5MnOHrTarr4_k0hiddxq69Q@mail.gmail.com>
Message-ID: <CAHk-=whyW9TXfYxyxUW6hP9e0A=5MnOHrTarr4_k0hiddxq69Q@mail.gmail.com>
Subject: Re: [PATCH 5.6 00/23] 5.6.1-rc1 review
To:     Naresh Kamboju <naresh.kamboju@linaro.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        open list <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Shuah Khan <shuah@kernel.org>, patches@kernelci.org,
        Ben Hutchings <ben.hutchings@codethink.co.uk>,
        lkft-triage@lists.linaro.org,
        linux- stable <stable@vger.kernel.org>,
        Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 31, 2020 at 11:08 AM Naresh Kamboju
<naresh.kamboju@linaro.org> wrote:
>
> Perf build broken on Linux next and mainline and now on stable-rc-5.6 branch.

Strange. What is it that triggers the problem for you? It works fine
here.. The error looks like some kind of command line quoting error,
but I don't see the direct cause.

Have you bisected the failure? Build failures should be particularly
easy and quick to bisect.

                Linus
