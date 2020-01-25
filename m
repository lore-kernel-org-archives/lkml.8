Return-Path: <SRS0=aedO=3O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 967D1C35242
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Jan 2020 22:43:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6303120708
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Jan 2020 22:43:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LbVP9dqB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727964AbgAYWnh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 25 Jan 2020 17:43:37 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:40114 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727163AbgAYWnh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Jan 2020 17:43:37 -0500
Received: by mail-pf1-f193.google.com with SMTP id q8so2995348pfh.7
        for <linux-kernel@vger.kernel.org>; Sat, 25 Jan 2020 14:43:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:message-id:mime-version:subject:date:in-reply-to:cc:to
         :references;
        bh=AOLTnVNQQBP5W6Qmk7dCZgA888ERshWdgw05gSNGlL0=;
        b=LbVP9dqBPxh6GqWNK4OtDHPAEhhvDKjxGrcKNnI+B5yAR1DVGWsc553MVJ0c4DffcB
         Muvk74H8ptBJINyTpGytc6zaDcugWxKOEc/zMcTYh1iszvPVHTIxjucqmriG6JYyXeqa
         tf229tG6NtqrF/qS8lfBh3STd9+IjzGZTXx41d2YHkDDH3+hCmPE4by3lh8+yddAk+cE
         UAZZhvzed5hS2IkfoHuwUyJ/ZfLHKqcbgD/gpwapKUD/Tr4zC2wqNXY8m6sWRvp4HtBx
         g63kTLv1xV11VVmQ91rTpAPaaVBplexndkhn0HKXfkH872Wk+9gLXxlgU2db3wZ2zMC2
         yXuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:message-id:mime-version:subject:date
         :in-reply-to:cc:to:references;
        bh=AOLTnVNQQBP5W6Qmk7dCZgA888ERshWdgw05gSNGlL0=;
        b=pNxF0mvN5fiDbBCRNJP7mRkBNPWcH/l4Uputa7JZ/7a4CYH08rZNsC4Kul5HnMI4Db
         ySJZuH0Cf7+wTGDJ5HeE+N98S2xckEHFV4RCEJdPOQCdsZq6tCULOv4SXn3TW1JY+SPw
         OEbr0qUzauxlN4ihY9na5hWkuJcQ/T7ytBrjebJqQqfwyV1O4ixU17SgqtAaryhzwEE1
         FpDckozi/Y4JqNHJ9iU0EukLfP1iyGI+8YhNkc2lbFneu27RZACVjtHEHxtht3W8vGQw
         i9q4csfwvPgY8PU6v5eSD53AQbaGJOUfdfPABb+ZnYzeA2S/OXgua9yb9Q4DCqQazGGn
         vabw==
X-Gm-Message-State: APjAAAWvh5bV0CAfrK9C55qjOz9BQ9j/dPkiLbTTWSYlhPciVvo9UKAW
        P9uIT9MJXeV0LDIg5AiccP0=
X-Google-Smtp-Source: APXvYqy7t06KmSIn7byXvYvuQ4aGynoKrg3vTXQOxnsEol16URH8qKc26m2k98u3NzaknSBd/dOpGg==
X-Received: by 2002:aa7:820d:: with SMTP id k13mr9943241pfi.10.1579992216216;
        Sat, 25 Jan 2020 14:43:36 -0800 (PST)
Received: from [192.168.1.173] (c-76-21-111-180.hsd1.ca.comcast.net. [76.21.111.180])
        by smtp.gmail.com with ESMTPSA id w11sm10388273pfn.4.2020.01.25.14.43.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 25 Jan 2020 14:43:35 -0800 (PST)
From:   Mark D Rustad <mrustad@gmail.com>
Message-Id: <4E95BFAA-A115-4159-AA4F-6AAB548C6E6C@gmail.com>
Content-Type: multipart/signed;
        boundary="Apple-Mail=_96A2D9E9-5BC9-4886-ACE9-60D07BD7E836";
        protocol="application/pgp-signature";
        micalg=pgp-sha256
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: [PATCH v16] x86/split_lock: Enable split lock detection by kernel
Date:   Sat, 25 Jan 2020 14:43:33 -0800
In-Reply-To: <20200125220706.GA18290@agluck-desk2.amr.corp.intel.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        "Christopherson, Sean J" <sean.j.christopherson@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        "Yu, Fenghua" <fenghua.yu@intel.com>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        H Peter Anvin <hpa@zytor.com>,
        "Raj, Ashok" <ashok.raj@intel.com>,
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>, x86 <x86@kernel.org>
To:     "Luck, Tony" <tony.luck@intel.com>
References: <20200122185514.GA16010@agluck-desk2.amr.corp.intel.com>
 <20200122224245.GA2331824@rani.riverdale.lan>
 <3908561D78D1C84285E8C5FCA982C28F7F54887A@ORSMSX114.amr.corp.intel.com>
 <20200123004507.GA2403906@rani.riverdale.lan>
 <20200123035359.GA23659@agluck-desk2.amr.corp.intel.com>
 <20200123044514.GA2453000@rani.riverdale.lan>
 <20200123231652.GA4457@agluck-desk2.amr.corp.intel.com>
 <87h80kmta4.fsf@nanos.tec.linutronix.de>
 <20200125024727.GA32483@agluck-desk2.amr.corp.intel.com>
 <875zgzmz5e.fsf@nanos.tec.linutronix.de>
 <20200125220706.GA18290@agluck-desk2.amr.corp.intel.com>
X-Mailer: Apple Mail (2.3445.104.11)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Apple-Mail=_96A2D9E9-5BC9-4886-ACE9-60D07BD7E836
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	charset=us-ascii;
	delsp=yes;
	format=flowed

On Jan 25, 2020, at 2:07 PM, Luck, Tony <tony.luck@intel.com> wrote:

>   - Transitioning between modes at runtime isn't supported and disabling
>     is tracked per task, so hardware will always reach a steady state that
>     matches the configured mode.

Maybe "isn't supported" is not really the right wording. I would think that  
if it truly weren't supported that you really shouldn't be changing the  
mode at all at runtime. Do you really just mean "isn't atomic"? Or is there  
something deeper about it? If so, are there other possible risks associated  
with changing the mode at runtime?

Sorry, the wording just happened to catch my eye and my mind immediately  
went to "how can you be doing something that is not supported?"

--
Mark Rustad, MRustad@gmail.com

--Apple-Mail=_96A2D9E9-5BC9-4886-ACE9-60D07BD7E836
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - http://gpgtools.org

iQIzBAEBCAAdFiEE6ug8b0Wg+ULmnksNPA7/547j7m4FAl4sxJUACgkQPA7/547j
7m6fGg/8DRLCqJy1zWIUGJMYPBZgTgFxPj7tdyfGy88BC3es4lulPgvdkD9Mj11z
42jKFnQCZWUhpzIlpVv5hO28TZp/L+bkZbUa5iukwCaL7NTN6eiCvoxOd+nqzby9
GWU5XLmFUvgiS4LiGqub4K6I33898xjVh9+R2cXfHZxUmGnPzvQT8Hjg85PBhsra
kWMKY9XLtu20vnBkwMpbj5PAhHDImF/aljoawgmnIo2xX1N2WNiWBOFNEWPqiP4M
ZZxTgeMye+MmrhktQJDH0To+dBtB+Hyu+nr8YG81wOZ1EMna7murx7obSQdXDI4x
DgPf3Q38JrJglTNe09I79+OjsQY+zLEG2oKkZ/NtKJ5x97AkVf4U3Cojuc8z27yW
kNF60eroJP8FKr/S1BUY5bcQ/nevNP5aIZkdjI0drqBwx1IzVhII8IDZB3zcmXh5
1lcO/p1U93x6VtF9pldl/ykQDjCIk3d8+dbpR6IrkSphkwLyUWBhh+4ZVRMSIoWw
bgWu7St106u5Ht/ECy8gsxIOXW0vycbqghgn8DMSB1HufnaAqNL+6Yjfr6l0Uk8c
5MM0q7dGYGpxvbdqS/dYfheb1kgEt9k7mT52Wi6Q8qI9ttNlNrT6xTAEElrMbT40
NbOHq4FcZDoF2gaPJzbt8MpzkH+y3yB2RopMkTFCs3E3Ck3dCIw=
=uBBO
-----END PGP SIGNATURE-----

--Apple-Mail=_96A2D9E9-5BC9-4886-ACE9-60D07BD7E836--
