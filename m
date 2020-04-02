Return-Path: <SRS0=iZC5=5S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E9FDC2BA12
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 18:26:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E78AF208E0
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 18:26:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="Qud39i5g"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389466AbgDBS0G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Apr 2020 14:26:06 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:44762 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732330AbgDBS0G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Apr 2020 14:26:06 -0400
Received: by mail-ed1-f68.google.com with SMTP id i16so5518610edy.11
        for <linux-kernel@vger.kernel.org>; Thu, 02 Apr 2020 11:26:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Fsju25xR5Bkh9oVvatIsUHlFON5AMunMtmppuDrSEUU=;
        b=Qud39i5gX6ZMhp0mFgmL/kMy4jbCm1vzQ93KZS5TnlyvU3caUbLZ2F6eq2snrxSmL4
         B4c3otnPkXXyUJFEbha+EcrtM0HPP/pxsZOBuxaouBxUMVUTHBlWtkQa4cH7TUOvuFHk
         N6IcK39ivOtzoKAOe7S/TaiLHEJDqrgcPM2Vc8vnehShJXuNIHabSU/yQFkYSCDRMJm6
         IxbYpDhfUrDqEjHIWfn2eugCt/dD4CngXDtGdy+Crd3wdtjYE4K1yWzcF59OFslcVWYT
         TF/Ge6rqaGB2XQwZkthZ/LWlwokoUFAIn0KBOlodoKS700Ey7YN64T8Crmfbff9CGvE7
         51kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Fsju25xR5Bkh9oVvatIsUHlFON5AMunMtmppuDrSEUU=;
        b=FxuSBqmcQy33jHyv7g+VoMuZe/kRsGnbjO5OiYIW8wBd8dsOEVNE6cX1cy6Al+JBle
         sGYV8FDBC8H2jKo5OOq7nLLjYNOI1e8boa9oxN7JjaAKuZUzNLsyTS2QxAOtC5LSQtmD
         40c30I8DEKEt76Ls84w3fMk2MhJsQWkElxI8YpLoeF5aXj0NZvhzCv8kecPbn72h8y9G
         UUas51IV14uKMQ0H0OF8iKFwi4xQQuOOUsolTFaeFTnWOJ3ZkowXApHhv14sT2xyMzg4
         7w9V1N2zNYK5219zW8h7YnuNcXtlZi1Crj6HDPqN9eR6HFdnK7QrHrA0hFTw5z0XCgvj
         3F/Q==
X-Gm-Message-State: AGi0PuYP+bDEcNFBTo+TgQhZE298oA8FEw/Gr0yJiwAiwEmtQNO5z9T+
        u0SvcznnjidI0GsGNmj3Bo3xhoB5wFOPTlcJurywUQ==
X-Google-Smtp-Source: APiQypLyZlnBFts+hTuVWEB4oReBowZHryisrXt76Sal+1uE8+e1hO1H7o5Z0D+aEv1q3Ey/I3oOamvXgaJs2b81knc=
X-Received: by 2002:a17:906:7045:: with SMTP id r5mr4673336ejj.29.1585851964949;
 Thu, 02 Apr 2020 11:26:04 -0700 (PDT)
MIME-Version: 1.0
References: <20200401225723.14164-1-pasha.tatashin@soleen.com>
 <20200401225723.14164-3-pasha.tatashin@soleen.com> <bd3db378-f5d5-0058-0a42-4ed6033439a8@redhat.com>
 <20200402074732.GJ22681@dhcp22.suse.cz> <CA+CK2bAFsTJT2zU=+OyHj_-=zTKbw6mLHzrc2VEoGjPQpfhppQ@mail.gmail.com>
 <20200402171631.GU22681@dhcp22.suse.cz>
In-Reply-To: <20200402171631.GU22681@dhcp22.suse.cz>
From:   Pavel Tatashin <pasha.tatashin@soleen.com>
Date:   Thu, 2 Apr 2020 14:25:54 -0400
Message-ID: <CA+CK2bC5byyrA7Rf=ORmSF9Vfnik5vD-fR4=76G+5evXSOKOmg@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] mm: initialize deferred pages with interrupts enabled
To:     Michal Hocko <mhocko@kernel.org>
Cc:     David Hildenbrand <david@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-mm <linux-mm@kvack.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Shile Zhang <shile.zhang@linux.alibaba.com>,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        Kirill Tkhai <ktkhai@virtuozzo.com>,
        James Morris <jmorris@namei.org>,
        Sasha Levin <sashal@kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > So, should I move it to a separate patch or is it OK to keep it here?
>
> Having in a separate patch would be better IMO. If for nothing else, the
> RCU stall would be easier to see.

Sure, I will submit it as a separate patch.

Thank you,
Pasha
