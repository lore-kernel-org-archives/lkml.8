Return-Path: <SRS0=EowN=3M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81957C33CB6
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jan 2020 21:41:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A67020665
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jan 2020 21:41:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KS1rkwsQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729107AbgAWVlg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jan 2020 16:41:36 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:41388 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726118AbgAWVlf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jan 2020 16:41:35 -0500
Received: by mail-wr1-f65.google.com with SMTP id c9so4901271wrw.8;
        Thu, 23 Jan 2020 13:41:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to;
        bh=p9ycD1KKNwyUkmWBToIQ3KVq6i0YJgB1Ain7Uuh2aNY=;
        b=KS1rkwsQezonMgz0iAwuGLDncnNMFRtzunTP64BP6M2Om+O2AWYYirYpuIm9BZr6qX
         jzH3E1NULnF/K8r5UQuOcicU5QtXGcmK0vHCnQrIouGSBFL+c3DSMpdgdObFiokP3VrE
         ezTHeBGXnGTB7ZcsDCj6dpAAi7fanTuIDv2SGgjs6s7CEEyeDkzEwu5ewglXpsMShjWD
         dONrL2rcwOk6G96Q2HF2Bu2w5rlykgaDY3uYSRySPZ5D1PdTPIfMA0V2YPicEyvI7MvV
         je8zpz0xZlGV/x2xBhI3OpDouN6H/20ag7e2Ma85FZ9RJFUeEWD3h8zB8oGFDuy5ewGR
         IlPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to;
        bh=p9ycD1KKNwyUkmWBToIQ3KVq6i0YJgB1Ain7Uuh2aNY=;
        b=KAR9lAhEzvKEK4vJdjIclna31QFVx/53fg310EYlfspfIfX6mvjU15znudSGT1k273
         b+3+H1WHJgUpxamjhZfQZbwMN2ukozQ/86YZpP8PrP9te+ELE795AGZngLLYzdF+Etnz
         finxt3FyrZKrefODztMDWbLuLr9waQA6r4D3X2MgypnlmsM2qRat25BX1u8QO2z3c7ov
         ei3bQADFuYjCCvV/iXtk75ZFuicwG7hq69aL6cB02L7LIYyKlmfKjRnzj0EljFxQUbK0
         E0W0VJHBXzClL7FsEYbItNov2KypFK2kyiHCdNoc2e13YKVux7w9VRTkiWWUDvDP1yI3
         ml9w==
X-Gm-Message-State: APjAAAUB6W8czom9wSFMbXty6knts7GSCVAfnlZZ3TCSTjhrLZIt1dUo
        sbJgVbtZgtWHxcgwCBcdcpE=
X-Google-Smtp-Source: APXvYqw5VcbIPl+K5kelifhJFMRrX22+H5xmQeVDIbk6aSVpezxGpZzsRpjRNbivALa6BC5dF4tofA==
X-Received: by 2002:adf:f990:: with SMTP id f16mr90732wrr.185.1579815693377;
        Thu, 23 Jan 2020 13:41:33 -0800 (PST)
Received: from x1cbn.MEGAROWIFI.local ([5.148.123.66])
        by smtp.gmail.com with ESMTPSA id p5sm4500685wrt.79.2020.01.23.13.41.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jan 2020 13:41:32 -0800 (PST)
From:   SeongJae Park <sj38.park@gmail.com>
To:     Brendan Higgins <brendanhiggins@google.com>
Cc:     SeongJae Park <sjpark@amazon.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        mgorman@suse.de, SeongJae Park <sj38.park@gmail.com>,
        SeongJae Park <sjpark@amazon.de>
Subject: Re: Re: [RFC PATCH 4/5] Documentation/admin-guide/mm: Add a document for DAMON
Date:   Thu, 23 Jan 2020 22:41:27 +0100
Message-Id: <20200123214127.14945-1-sj38.park@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <CAFd5g44WpJQTDG9TK6xB0VYB92qnR=0g1nGcZOF60Bf2X7XB5Q@mail.gmail.com> (raw)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 23 Jan 2020 13:17:04 -0800 Brendan Higgins <brendanhiggins@google.com> wrote:

> On Fri, Jan 10, 2020 at 5:16 AM SeongJae Park <sjpark@amazon.com> wrote:
> >
> > From: SeongJae Park <sjpark@amazon.de>
> >
> > This commit adds a simple document for DAMON under
> > 'Documentation/admin-guide/mm/'.
> >
> > Signed-off-by: SeongJae Park <sjpark@amazon.de>
> > ---
> >  .../admin-guide/mm/data_access_monitor.rst    | 235 ++++++++++++++++++
> >  Documentation/admin-guide/mm/index.rst        |   1 +
> >  2 files changed, 236 insertions(+)
> >  create mode 100644 Documentation/admin-guide/mm/data_access_monitor.rst
> >
> > diff --git a/Documentation/admin-guide/mm/data_access_monitor.rst b/Documentation/admin-guide/mm/data_access_monitor.rst
> > new file mode 100644
> > index 000000000000..907a7af75f35
> > --- /dev/null
> > +++ b/Documentation/admin-guide/mm/data_access_monitor.rst
> > @@ -0,0 +1,235 @@
> > +.. _data_access_monitor:
> > +
> > +==========================
> > +DAMON: Data Access MONitor
> > +==========================
> > +
> > +
[...]
> > +
> > +Quick Tutorial
> > +--------------
> > +
> > +To test DAMON on your system,
> > +
> > +1. Ensure your kernel is built with CONFIG_DAMON turned on, and debugfs is
> > +   mounted at ``/sys/kernel/debug/``.
> > +2. ``<your kernel source tree>/tools/damon/damn -h``
> 
> I think it would be helpful for the reader to provide an example of
> what they should expect to see here.

Totally agreed.

Will apply your suggestion by next spin.


Thanks,
SeongJae Park

> 
> > diff --git a/Documentation/admin-guide/mm/index.rst b/Documentation/admin-guide/mm/index.rst
> > index 11db46448354..d3d0ba373eb6 100644
> > --- a/Documentation/admin-guide/mm/index.rst
> > +++ b/Documentation/admin-guide/mm/index.rst
> > @@ -27,6 +27,7 @@ the Linux memory management.
> >
> >     concepts
> >     cma_debugfs
> > +   data_access_monitor
> >     hugetlbpage
> >     idle_page_tracking
> >     ksm
> > --
> > 2.17.1
> >
