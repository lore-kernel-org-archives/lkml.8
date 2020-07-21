Return-Path: <SRS0=jpuI=BA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF75AC433E7
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 11:44:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8A13E2073A
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 11:44:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="D+gl//id"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729316AbgGULoK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jul 2020 07:44:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728560AbgGULoJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jul 2020 07:44:09 -0400
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92FFDC061794
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jul 2020 04:44:09 -0700 (PDT)
Received: by mail-qk1-x743.google.com with SMTP id 11so9404777qkn.2
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jul 2020 04:44:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=content-transfer-encoding:from:mime-version:subject:date:message-id
         :references:cc:in-reply-to:to;
        bh=JkLTqUSBRUuKpZ5ZCYN1xKhQ405tLy+Ys8G86xno/fg=;
        b=D+gl//id0PU4FSCM9quXGNwKUbe/L8HeI5BWlFcUccDBfjUhNceRarNqpFqMM5itIq
         wx9I/Lor5UySH47NQ/dU1IuyhKt2hBLq+hem0iPJ6sjIzVwWpF0quqVddFRPKkrMHazK
         HPvASbxbFHzIXL1i6l0g6Ib7YgpkJAoh67qVbBmM+QuIRFZW6N3CktMBwbA3Nw5fAhkp
         c8LuE2Kk3cWgBzq69mbnFF+c4rtuHCiBkJuU+WLELgrsB0WuvxVOGtub3UtJcvUV7KuN
         qUrgVCMNE2Fr4/G5tAfBiFGwanFQNC0SAjj33TOPY0oUTCqhuV3IpmtuluiL5tgCg3n9
         iACA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version
         :subject:date:message-id:references:cc:in-reply-to:to;
        bh=JkLTqUSBRUuKpZ5ZCYN1xKhQ405tLy+Ys8G86xno/fg=;
        b=H3tXZ2ZbNXHa4Q4x8qFuE3PF+5a5ue0Owfcy3TAL3xiIPEPE4anLc9YzFUIHgxNjmu
         sf+B+4fYQJpcWQsYV8pq1Ha1hkS+1mSvO4v+T7tUgpGQG4rCd+F9dXr1K8bmpCrCENpk
         /EKcNI61bW2n+7hEYO2iw6Yxh+RXGhmFlNGj8s29aEdKBU27Oa4G3Tm6hCMB9ZWdxsHS
         lenJjljIWQwYwgxBf81ZxgX/Cv6yl4MLnqQMZUEOqSk72QrPu1hDIj77cYucBJDwrAGw
         Fru29fczBeKCXSd6F3UQ1oUoN2V9YAsonOzfzazxD5bh+xstzUsoB6xwL5iU95tl7Q8f
         WUSA==
X-Gm-Message-State: AOAM533+4yyvpnt1nqLiHb2jNu+bIYWomZSwBdhEO/si69Z1mjL4IVUK
        yG7dvFdqvONgNvC4js53zXQxVg==
X-Google-Smtp-Source: ABdhPJz+m91AzTJAYvWj/hvlGxZ7YttZHhqDuSVhHEXQuTiIzsbS6dDFY4kAfz8rqFvZYSocPOYRSw==
X-Received: by 2002:a37:7242:: with SMTP id n63mr26655272qkc.143.1595331848849;
        Tue, 21 Jul 2020 04:44:08 -0700 (PDT)
Received: from [192.168.1.183] (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id o18sm2009257qkk.91.2020.07.21.04.44.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Jul 2020 04:44:08 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   Qian Cai <cai@lca.pw>
Mime-Version: 1.0 (1.0)
Subject: Re: [RFC PATCH] mm: silence soft lockups from unlock_page
Date:   Tue, 21 Jul 2020 07:44:07 -0400
Message-Id: <664A07B6-DBCD-4520-84F1-241A4E7A339F@lca.pw>
References: <20200721112529.GJ4061@dhcp22.suse.cz>
Cc:     linux-mm@kvack.org, LKML <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Tim Chen <tim.c.chen@linux.intel.com>
In-Reply-To: <20200721112529.GJ4061@dhcp22.suse.cz>
To:     Michal Hocko <mhocko@kernel.org>
X-Mailer: iPhone Mail (17F80)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Jul 21, 2020, at 7:25 AM, Michal Hocko <mhocko@kernel.org> wrote:
>=20
> Are these really important? I believe I can dig that out from the bug
> report but I didn't really consider that important enough.

Please dig them out. We have also been running those things on =E2=80=9Clarg=
e=E2=80=9D powerpc as well and never saw such soft-lockups. Those details ma=
y give us some clues about the actual problem. Once we understand the proble=
m better, we may judge if this =E2=80=9Chack=E2=80=9D is really worth it.=
