Return-Path: <SRS0=Xzqw=5F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 656E9C4332B
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Mar 2020 13:50:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3802520722
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Mar 2020 13:50:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SlIGit1n"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727337AbgCTNuM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Mar 2020 09:50:12 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:45869 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726843AbgCTNuL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Mar 2020 09:50:11 -0400
Received: by mail-pg1-f193.google.com with SMTP id m15so3095966pgv.12;
        Fri, 20 Mar 2020 06:50:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+Fx6oA7jCuDE18WfPJWcAtH6HJ8W48kIoWQ2M4dnYLQ=;
        b=SlIGit1n78vpYqCHXLeA58VBwdG1O5hZ+ob/HwUbL1XWsBANhUm4T55Rnn//EWSRhB
         bCYj2Qngr+qsVkBWDL9J4Hw69j/5rlL2b3fr+YTt/g0s9CjgB3CTvcGARPF6pq7L+3WH
         ABpgBrgzZiqP0k9Rh/n8+UqG/52JZvHatBjhg5vfWHbA8EbMqULMgweoS+Y1QcklQ2O2
         fIDfPCrFgM9NHVVcDFmuM48NQ/5L3GfCeiBqq9WMt/E8hdZMYbopwHmyCLcW93RR4bTh
         0IPtF3Yz2bqmOhC9YXoyM+MOdrdHYQ/7MoJey0CD9rfqXV7vYpqKDgh9fYvfXB/PgmlI
         pmaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+Fx6oA7jCuDE18WfPJWcAtH6HJ8W48kIoWQ2M4dnYLQ=;
        b=GYqw2q0lsmqr/8V/Y8w4oJsLk2yYSEHssVCpYifVf+BQLG9tNBvBXLx7bCB+JiKzwV
         zValQThrZfWwrtIrSFU3cFVYwwFBQ8RJ+iiSKr8FUyvbNFSniCXVpnBsbqSP7T3mWCWU
         UaP6nn3EY8wWN2y47DSUUOkMqbGwgdvy7HgATPlWoPFKYz8IkmnYXE6HhRFgXbq85vua
         wQCYk0iqcH2Id8wRc3NiqLASO3LpOP1DG8GBSitcanLyDlPWe0vyX3dkGpccuSmO/V+g
         kzchzaNyP1PswRN2aJzp1zltHPQupWfvY7a4WQMeGGkOF3m4dP+RjMR93MPveyCG0c7F
         suqQ==
X-Gm-Message-State: ANhLgQ1bNQuJ1NrlUauxPeAR4tLpQxVF8Vq4t9w9pyG2ioKpDU0sPxp2
        OKl8Ii5l0lvifPvzz5u6EDnGiwDSJ7b3lpqLRdA=
X-Google-Smtp-Source: ADFU+vtAuiXSoY2iyX+5K/WkTZaYgCh0XETfaCT5+G4xqs+Nt3AjoJI+569URseqadDHO9HVE53hrN86ctUVAJ08lAw=
X-Received: by 2002:aa7:8149:: with SMTP id d9mr9566637pfn.170.1584712210268;
 Fri, 20 Mar 2020 06:50:10 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1583093898.git.gayatri.kammela@intel.com>
 <20200302125427.GV1224808@smile.fi.intel.com> <BYAPR11MB362421570806431752364CD3F2E70@BYAPR11MB3624.namprd11.prod.outlook.com>
 <BYAPR11MB3624F3CB24817BB8C5AE6C10F2F40@BYAPR11MB3624.namprd11.prod.outlook.com>
 <20200319180618.GN1922688@smile.fi.intel.com> <BYAPR11MB3624FFB1B25DD743F473AFFEF2F40@BYAPR11MB3624.namprd11.prod.outlook.com>
In-Reply-To: <BYAPR11MB3624FFB1B25DD743F473AFFEF2F40@BYAPR11MB3624.namprd11.prod.outlook.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Fri, 20 Mar 2020 15:50:03 +0200
Message-ID: <CAHp75VcnE11pTyB2wPPe596+vRf_B1monV8NDHF_TBuGv9h64Q@mail.gmail.com>
Subject: Re: [PATCH v3 0/5] platform/x86: intel_pmc_core: Add bug fixes or code
To:     "Kammela, Gayatri" <gayatri.kammela@intel.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        "platform-driver-x86@vger.kernel.org" 
        <platform-driver-x86@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Somayaji, Vishwanath" <vishwanath.somayaji@intel.com>,
        "dvhart@infradead.org" <dvhart@infradead.org>,
        "Westerberg, Mika" <mika.westerberg@intel.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "Prestopine, Charles D" <charles.d.prestopine@intel.com>,
        Chen Zhou <chenzhou10@huawei.com>,
        "Box, David E" <david.e.box@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 19, 2020 at 8:16 PM Kammela, Gayatri
<gayatri.kammela@intel.com> wrote:
>
> > Is it in my review and testing queue?
>
> I think it is archived and superseded https://patchwork.kernel.org/patch/11414379/

Now everything in for-next, check if something is missed and resend.

-- 
With Best Regards,
Andy Shevchenko
