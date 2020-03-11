Return-Path: <SRS0=Ktsx=44=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D63CBC10DCE
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 00:04:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7BA4921D56
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 00:04:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="E2WEtHLm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727709AbgCKAEP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Mar 2020 20:04:15 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:36944 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726899AbgCKAEP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Mar 2020 20:04:15 -0400
Received: by mail-qk1-f196.google.com with SMTP id y126so435282qke.4
        for <linux-kernel@vger.kernel.org>; Tue, 10 Mar 2020 17:04:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=kC2peWxJ+qm6+wzfyf0pDsl2H945cR1gyhQhbsBrJUE=;
        b=E2WEtHLmwgB1sqZ9NdN+PYhK/kzD9WlEKX/XMkqkvWCWgVvKOdHt3kMMRwtGfKRedx
         QsHdLUiE9T/DCGZnU+D3JmKEHaXbAlZw33XyyKsnL4XHMyDuuZcaq2W0rlKEV98nBwyh
         Q+YaCLmxO0cP74zP1i1WT34kG+5Y6HXbSFaP7yuHmRzWGFTGDRQ4I0VPFwEmU408GL9t
         YFrllVedIhQ7MkNwS5EzCYRzr3NTi8htqDcq920NygGPq565EI+nBd7M53aNAKuMiePM
         LSo5JbqR4rfT8Blrr8ChWL888Avah/D0nF/RIs3usG2MvXnSKLbhKaBlylwEX3uJkwrK
         lgbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=kC2peWxJ+qm6+wzfyf0pDsl2H945cR1gyhQhbsBrJUE=;
        b=PJlv4OzO9fB021yMGJqHtfmr0wDsBLfx0Tmb21f4mEbZ/dgP01ciSJTi7vrtVjqgSh
         QYi83oM0103Si8kQYiC9TfV/K++OvtDHsvnVa6VrpjKAEOMF3owfjNbSK2KieXEBY+NU
         qqYM+8QDdzzkZ+2UyhDarHI3/W3/5Dd05WJfjbhC7DdjT1S8BWmVN0wxSJ626qkLq2fv
         wjGB1xuUW/ofDEy4dZZbOT6BXwp9lFRLYuiIdEzKRnqrjQpEf1AvNaRafCp1c5PjPCFv
         BrEcM4UbLl70SFXch3cNC8Zesjw6GzTk4wcHvfCCsVf5NqviUXoLBAXV0Pch3hBs1D/z
         hV5Q==
X-Gm-Message-State: ANhLgQ0UpKeAqU2QC+ZNK4QpSozJJiTGaQULlKoAWZxMJobaSm6IpwXM
        49gV+EP4PH9b1XEqNWfXIFXg6A==
X-Google-Smtp-Source: ADFU+vtmJ6y6O/Iq61etnzU2K2Cxevzv7kwYYoSGBz/QzRp5dQLU85KeY+jR709MQ0G+347olKfG2g==
X-Received: by 2002:a05:620a:109a:: with SMTP id g26mr416744qkk.166.1583885053989;
        Tue, 10 Mar 2020 17:04:13 -0700 (PDT)
Received: from [192.168.1.153] (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id i28sm25764085qtc.57.2020.03.10.17.04.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 10 Mar 2020 17:04:13 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.0 \(3608.60.0.2.5\))
Subject: Re: [PATCH] mm, numa: fix bad pmd by atomically check for
 pmd_trans_huge when marking page tables prot_numa
From:   Qian Cai <cai@lca.pw>
In-Reply-To: <20200309150531.GD25642@optiplex-lnx>
Date:   Tue, 10 Mar 2020 20:04:11 -0400
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        mgorman <mgorman@techsingularity.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        Vlastimil Babka <vbabka@suse.cz>
Content-Transfer-Encoding: quoted-printable
Message-Id: <917137D2-FD66-4175-AC69-23F8206186C5@lca.pw>
References: <20200216191800.22423-1-aquini@redhat.com>
 <2E0766B8-DDD1-4448-8605-8535A16670FC@lca.pw> <20200307030530.GB4093@t490s>
 <9124C8B9-FB47-44F5-8606-DD9261BCB383@lca.pw> <20200308231423.GA22348@t490s>
 <C5CED45A-FFDA-46C7-A116-284431CF5940@lca.pw>
 <20200309150531.GD25642@optiplex-lnx>
To:     Rafael Aquini <aquini@redhat.com>
X-Mailer: Apple Mail (2.3608.60.0.2.5)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Mar 9, 2020, at 11:05 AM, Rafael Aquini <aquini@redhat.com> wrote:
> I'm still waiting on a similar system to become available, so I can
> work on your reproducer case, as well as to dig and wrap my head =
around it.
>=20
> I still don't think that skipping the pmd_none() in the =
change-protection walk=20
> should cause a big fuss like you observed here (yet, it seems it =
does), and=20
> the fact that we need that race window to take the __split_huge_pmd() =
suggests,
> at least to me, that we might be missing this proper split somewhere =
else.

I have sent out another patch which should be more correct,

https://lore.kernel.org/lkml/20200310235846.1319-1-cai@lca.pw/=
