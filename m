Return-Path: <SRS0=QAx1=7P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33C3BC433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 04:02:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F10CE20870
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 04:02:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="jRp6tZ1+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726370AbgFBEC1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jun 2020 00:02:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726110AbgFBECZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jun 2020 00:02:25 -0400
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CB37C061A0E
        for <linux-kernel@vger.kernel.org>; Mon,  1 Jun 2020 21:02:25 -0700 (PDT)
Received: by mail-qk1-x741.google.com with SMTP id v79so11275584qkb.10
        for <linux-kernel@vger.kernel.org>; Mon, 01 Jun 2020 21:02:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=content-transfer-encoding:from:mime-version:date:subject:message-id
         :cc:to;
        bh=GMRYb8RFRRtwlzEMKi7MT1e7/aWKzB1rdupbFt9KNtw=;
        b=jRp6tZ1+10Pww1SnEP6YZSCKZrfK4Bb0tu4iuVM86ZsK77NQneS5pHXcnc8qqfJM4z
         CqtON3na4dFSWJARhtLOlhCx6w/72Gh8GW6rc/fdQf497drxJo7L55uuddB4lV+YZnaJ
         RUyuIxwhycaJ1fHxSMCSCQtsHeka6H8dpkN1S1opSmV2dLmnKVpvy4uT8hQAfHmqQtKD
         3fcmTOOwczWMkM6M0jMaw/a8o33ZCPi7ZmfsLXSTLM/+xP7VcD6dnECwnV2WX1vL0G6+
         NHfZYMz90q7jajQ/rTJDlhR1kLzGINO0pVCp8QGU+naPWdgagXGOM/iXMXmLZNdp6mvD
         yXhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version:date
         :subject:message-id:cc:to;
        bh=GMRYb8RFRRtwlzEMKi7MT1e7/aWKzB1rdupbFt9KNtw=;
        b=C4WyamebI8BXb1+8lwEGo0F1b30dh0lb/bnlVMBF/09p8/ax0pD9L0dIOelL3EoaBc
         qUXnyS8LVVw/cA1Fg/QcmAgavS5humgQLCQewE+ofhoUDQzFlLv3vWf71cBBuwEZDafE
         Q4JteIduNfgYqML57yz0zTZSSQY+P0J4Y6snYv9OmAybwNe10qqyBcdl7KDgl06cv6W6
         Wv6qzhXqa1a+r74JMhxLF7fW8O91zLN7b055OOzYdKTyBs6fjqlmHdI/2QjLjoWuffD7
         NFSJ6D+RTx+14Cr0KG6rpzVoW+5Xag3Qzqplj+2As/IHyecWRdb+7c3kNBDstlmy8IsT
         b8ug==
X-Gm-Message-State: AOAM531HuD8M7OYv6l6e1eFCmTNxlrJ+ZrfoqhgaMYfappCdA9QMZH/G
        OV/c/IOxHaEKundz4S6eQGUlPQ==
X-Google-Smtp-Source: ABdhPJy/MJO7Qoq7doJPnEHbUf6iHSLmfO7PH+CZYb7yDFBioDv+2RchlNaB21JisJNsSLxwHGUMUA==
X-Received: by 2002:a37:8803:: with SMTP id k3mr16727466qkd.311.1591070543919;
        Mon, 01 Jun 2020 21:02:23 -0700 (PDT)
Received: from [192.168.1.183] (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id y185sm1071027qkd.83.2020.06.01.21.02.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Jun 2020 21:02:23 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   Qian Cai <cai@lca.pw>
Mime-Version: 1.0 (1.0)
Date:   Tue, 2 Jun 2020 00:02:22 -0400
Subject: Re: [PATCH v4 3/4] mm/util.c: remove the VM_WARN_ONCE for vm_committed_as underflow check
Message-Id: <E1703973-38C1-4AFB-94D1-E79DDC6853EE@lca.pw>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Matthew Wilcox <willy@infradead.org>,
        Mel Gorman <mgorman@suse.de>,
        Kees Cook <keescook@chromium.org>, andi.kleen@intel.com,
        tim.c.chen@intel.com, dave.hansen@intel.com, ying.huang@intel.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Konstantin Khlebnikov <koct9i@gmail.com>
To:     Feng Tang <feng.tang@intel.com>
X-Mailer: iPhone Mail (17E262)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Jun 1, 2020, at 11:37 PM, Feng Tang <feng.tang@intel.com> wrote:
>=20
> I re-run the same benchmark with v5.7 and 5.7+remove_warning kernels,
> the overall performance change is trivial (which is expected)
>=20
>   1330147            +0.1%    1331032        will-it-scale.72.processes
>=20
> But the perf stats of "self" shows big change for __vm_enough_memory()=20
>=20
>      0.27            -0.3        0.00        pp.self.__vm_enough_memory
>=20
> I post the full compare result in the end.

I don=E2=80=99t really see what that means exactly, but I suppose the warnin=
g is there for so long and no one seems notice much trouble (or benefit) bec=
ause of it, so I think you will probably need to come up with a proper justi=
fication to explain why it is a trouble now, and how your patchset suddenly s=
tart to trigger the warning as well as why it is no better way but to suffer=
 this debuggability regression (probably tiny but still).=
