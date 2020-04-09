Return-Path: <SRS0=n+Ub=5Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BE90C2BA19
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Apr 2020 17:58:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1661C206E9
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Apr 2020 17:58:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="UM9XOL7v"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726595AbgDIR6b (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Apr 2020 13:58:31 -0400
Received: from mail-qv1-f67.google.com ([209.85.219.67]:44022 "EHLO
        mail-qv1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725970AbgDIR6b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Apr 2020 13:58:31 -0400
Received: by mail-qv1-f67.google.com with SMTP id w26so2409774qvd.10
        for <linux-kernel@vger.kernel.org>; Thu, 09 Apr 2020 10:58:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=content-transfer-encoding:from:mime-version:subject:date:message-id
         :references:cc:in-reply-to:to;
        bh=vbNs4CiSAfqXtDc3PCTnCp4GWX4m5dGAR4EoeOkQXUw=;
        b=UM9XOL7vXw5YSDBrMqz1x5fbcySKBJPdcsGdK3G2BJ0HqC9qv+hf9slg74aPPBSGVt
         dWVpnEb2iFLsR3tMVpiwkXnEfLBQlixQeVzoaRqb8OftsbFS1z6oqaZUt5iijh8CBmVa
         5/7pZdIQoiOUGdSzlQw3Pcm9tVOHfFV1OtXxboM3HQxjRc5ItOJ8VyO0b39yy0FMuSDE
         Gvq1/k6PB54y/pPH4dz0RiaYpvkS2lMxOoZ6d6/CvPvQUBM/vg01hFqEY828coijVZLt
         bbfkmtMOisih9qOEkCB0mupjcrVt3roiDi56oBl/lah1LSsCj963Veb0DjFqBrXX9VOm
         616A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version
         :subject:date:message-id:references:cc:in-reply-to:to;
        bh=vbNs4CiSAfqXtDc3PCTnCp4GWX4m5dGAR4EoeOkQXUw=;
        b=b/eRm6enFFH0Yl1lNax8B4Rce3mGM7NZlXw6Q79ftlcaPxX4W53Sfgnbv5c3dl82L+
         tA6ElIdpmHhuyd7UT7Gq/LXYLJ+0Sme7S49W4B+yPchpF6FqmxJ6Cfjl4xl29JtMWR/r
         SdM3nF/mVoyyvi89GWKpOHkyve0XfZ+tRmIT2aChurQ0A64ms7kG5aogcjqjOydk21eK
         BG6xu3yLl1A8DY51SYmJdAon5mUaCeUMvapQm3aagA56A+lcfLjPApGrks+DrDpENwXc
         mXZtfuBqUBozXeS2+6Yn0RrraIYjNhEUTYX/BTQAQya05cbWKbZP/h4wLW6lYiqk0wBW
         8DDw==
X-Gm-Message-State: AGi0PubT/1X5uCGcsdvFuisR5l2EYvNkk4Yi9UXzcwtvcOENG2pQUdlq
        ebte6ACEDcKcsCyvwp70LYeWkw==
X-Google-Smtp-Source: APiQypJMAtakUPjlZdlWSuPXqIajVjJzQSZXFNNU6P6KqrKcxIi2dyKf4zVuhyyh1tJlmTDmVJkG/w==
X-Received: by 2002:ad4:49c6:: with SMTP id j6mr1367309qvy.68.1586455108881;
        Thu, 09 Apr 2020 10:58:28 -0700 (PDT)
Received: from [192.168.1.183] (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id e10sm9209798qtj.76.2020.04.09.10.58.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Apr 2020 10:58:28 -0700 (PDT)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
From:   Qian Cai <cai@lca.pw>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH 0/2] mm: Two small fixes for recent syzbot reports
Date:   Thu, 9 Apr 2020 13:58:27 -0400
Message-Id: <AFD0DADD-0558-463F-B219-5F098E6C2EDF@lca.pw>
References: <CAHk-=wjfngA7nHAsie7bW_JmKBhUyV9oV7zmDbZuchkJK3sR1w@mail.gmail.com>
Cc:     Dmitry Vyukov <dvyukov@google.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Andrew Morton <akpm@linux-foundation.org>,
        Peter Xu <peterx@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>
In-Reply-To: <CAHk-=wjfngA7nHAsie7bW_JmKBhUyV9oV7zmDbZuchkJK3sR1w@mail.gmail.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
X-Mailer: iPhone Mail (17D50)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Apr 9, 2020, at 1:05 PM, Linus Torvalds <torvalds@linux-foundation.org>=
 wrote:
>=20
> Well, probably not very many people outside of robots.
>=20
> Which is fine, but is also why I'd like robot failures to then be a big de=
al.

Agree to make a big deal part. My point is that when kicking trees of linux-=
next, it also could reduce the exposure of many patches (which could be bad)=
 to linux-next and miss valuable early testing either from robots or human. T=
hus, the same mistakes could happen again because maintainers could simply p=
ush those little or none linux-next exposure patches to mainline with no res=
trictions. There is a balance to strike.


