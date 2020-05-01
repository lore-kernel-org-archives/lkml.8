Return-Path: <SRS0=nvtT=6P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66F55C4724C
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 12:15:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 467D42051A
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 12:15:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="utcz2o21"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728690AbgEAMPo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 May 2020 08:15:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728485AbgEAMPn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 May 2020 08:15:43 -0400
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5ECC4C061A0C
        for <linux-kernel@vger.kernel.org>; Fri,  1 May 2020 05:15:42 -0700 (PDT)
Received: by mail-qk1-x742.google.com with SMTP id s9so6292252qkm.6
        for <linux-kernel@vger.kernel.org>; Fri, 01 May 2020 05:15:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=JYFbEmwByK1kSUV6PdffPqvoJKRC0gx+//umDk3k0Ps=;
        b=utcz2o21mWc2/XCNDWGllf7E65EoQXkohhOIrnumu60xq74MyeE2Ls/zpvpsN9N9zk
         la3EUwd2pzYhxPguLTzL52nfPUbVel2QFjaJLbf0A19TxrpDcCuFgYi/a8b435tJhJOF
         FtSQSRSouOthXdZfo6dqwSZfNJQ7YNM7pgITwsIdQ/4lDlDs94tI8ispGBSPkQSYrxrX
         CRx/WnMf95EGs69PHOsH3B39FNOkc5KVJtyB4FB75SfoCbyAgNqk2rI+qR9irEhD/XF7
         FzZ34oFtmKNnchILZVR22XTpOzyis+0Z5koivDOcTssL2wPhufeu/qYkbEAseLmY9/ml
         OOCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=JYFbEmwByK1kSUV6PdffPqvoJKRC0gx+//umDk3k0Ps=;
        b=bUIZvKc497NydSTMsVe2l/XdIKLoxfEEGmFi5DuGKYmQ4mmWWhwpf5qom8SfkqWNtT
         Ph8tXr2SudRtqfgsjkaEjniszvmpgkj7voDaLQ5Y89zB0h8+ZeJBg8CrDh2CzMMQ9uAi
         RoMxTC21NHk7ZaBJg4w4FO32NY/JiUfJa7uSFcZs0tGEO9HuKijY6BL7LYS+EvWHqzF0
         0flqklerSwahy5oVkt+Tnyb4teVsiQCURLaKnHamObXmq0qDrp5kgjmp8ggp4ca+5N6b
         0zYdQOo+evVggqQnl9OihXbgmdnaX4lubIhx+r9O4DRTlniTJZAHVP2FAPqSVOTbpccA
         /v6Q==
X-Gm-Message-State: AGi0PuZUpgIhUfh9yZz+RKiURrMNnB5W0+i5fRNHztcxMNrwfOSJ1EKs
        Av4usTzpU3ZAd9MRPfJXhL8saC+PvnftQRcBncA=
X-Google-Smtp-Source: APiQypI7vOl45fml4C9ZmaJpdoktGDh1UHo1sm6nSStD7g2v48BHr/d4jvPc2upoguAAq5WHoh0ijy8npq9J2KVj6zI=
X-Received: by 2002:a05:620a:1232:: with SMTP id v18mr3341347qkj.429.1588335341365;
 Fri, 01 May 2020 05:15:41 -0700 (PDT)
MIME-Version: 1.0
References: <1588130803-20527-1-git-send-email-iamjoonsoo.kim@lge.com>
 <20200429184711.9d603da097fdea80f574f1f1@linux-foundation.org>
 <CAAmzW4NC4LHXSoU8r6Jrh7WP8fouuaSkM--0gQVWf8G4wkDupg@mail.gmail.com> <20200501105545.GA29460@infradead.org>
In-Reply-To: <20200501105545.GA29460@infradead.org>
From:   Joonsoo Kim <js1304@gmail.com>
Date:   Fri, 1 May 2020 21:15:30 +0900
Message-ID: <CAAmzW4M+EoPqhossgJKxpZ_5=uto1jXK56qYmUd6SNKmbswuJQ@mail.gmail.com>
Subject: Re: [PATCH v2 00/10] change the implementation of the PageHighMem()
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Laura Abbott <labbott@redhat.com>,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Michal Hocko <mhocko@suse.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Roman Gushchin <guro@fb.com>, Minchan Kim <minchan@kernel.org>,
        Rik van Riel <riel@surriel.com>,
        Christian Koenig <christian.koenig@amd.com>,
        Huang Rui <ray.huang@amd.com>,
        Eric Biederman <ebiederm@xmission.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Pavel Machek <pavel@ucw.cz>, kernel-team@lge.com,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2020=EB=85=84 5=EC=9B=94 1=EC=9D=BC (=EA=B8=88) =EC=98=A4=ED=9B=84 7:55, Ch=
ristoph Hellwig <hch@infradead.org>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:
>
> On Fri, May 01, 2020 at 07:52:35PM +0900, Joonsoo Kim wrote:
> > > - New code will pop up which gets it wrong and nobody will notice for
> > >   a long time.
> >
> > Hmm... I think that it's not that hard to decide correct macro. If we r=
ename
> > PageHighMem() with PageDirectMapped(), they, PageDirectMapped() and
> > PageHighMemZone(), are self-explanation macro. There would be no
> > confusion to use.
>
> What confuses me is why we even need PageHighMemZone - mostly code
> should not care about particular zones.  Maybe just open coding
> PageHighMemZone makes more sense - it is a little more cumersome, but
> at least it makes it explicit what we check for.  I already sent you
> an incremental diff for one obvious place, but maybe we need to look
> through the remaining ones if we can kill them or open code them in an
> obvious way.

I think that PageHighMemZone() is long and complicated enough to have
a macro.

PageHighMemZone(page) =3D is_highmem_idx(zone_idx(page_zone(page))

Instead of open-code, how about changing the style of macro like as
page_from_highmem()? What PageHighMemZone() represent is derivated
attribute from the page so PageXXX() style may not be appropriate.

Thanks.
