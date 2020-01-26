Return-Path: <SRS0=fzvl=3P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FBC3C2D0DB
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Jan 2020 17:27:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D69A7206A2
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Jan 2020 17:27:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="owrv40dV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726548AbgAZR1Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 26 Jan 2020 12:27:25 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:44977 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725944AbgAZR1Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Jan 2020 12:27:24 -0500
Received: by mail-pg1-f193.google.com with SMTP id x7so3951126pgl.11
        for <linux-kernel@vger.kernel.org>; Sun, 26 Jan 2020 09:27:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:message-id:mime-version:subject:date:in-reply-to:cc:to
         :references;
        bh=yncP28iCZ/vH9/B+d6eZCrrs1L83buT+ZVEw1Q5Sr3Q=;
        b=owrv40dVDVxmIn/HTUIClDUKhhkG8yKgQEDU9aP4lgckOfEqguxK/vjW44fErEmN/R
         596esK7ExVgjLx9sUk8u/Q9W5mc0vi97L+9pmH6qYyCSNaO2XYYLr91g7CJQIGPSL4Yr
         SVew2rDwy70DtZVhdI79BRGSEOWyYBeI3MPf8qSkGxF/HzO2xXSlbvzGSlijauFTOkmy
         pX3gXGPtwij4qFCcxQ1M+xvl14KqBy+b12b7t3S4Z77m5+F0/QPQFqKxWurBhNNtKDi2
         zlMA9nK0UZqjvAbXSIhFC4vIfV6f8iLe2OfCtRcSWszhpnkPcGC0wMcXwyk6o0lmCUcm
         kQ7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:message-id:mime-version:subject:date
         :in-reply-to:cc:to:references;
        bh=yncP28iCZ/vH9/B+d6eZCrrs1L83buT+ZVEw1Q5Sr3Q=;
        b=FBGHVlBexHflHOioJUL/AH+f15Pl+vVbh/jQ0MVe+gI0MVsDDbUoeQo8Fsi3aG8k9p
         76ON2mtu4vYAynng5f0C3jwbyGLE42NRWoL8tP5UL5DLZyTwDtjpE0xoPItiEczq15Fa
         do8LXz2YyV3t36eJapJlgwqO+zjxL1DxDnUAu7jsHb5eT5e78C8nd7gMasXp6OFd/0iX
         1jLKVEjs16sR4dDoxlIkCBCIS3TCHJ8Ui4z6CsIhTD82pqtAcgNI/vQ+keQCgzHhFggF
         zjew424cQz0qyY6ipniur2XjRwy3QT7BU73OAnS+KaZjJzmSq7Od1t6KZ0RR3SUPXwDq
         cBsw==
X-Gm-Message-State: APjAAAWPsji1UIxhrwFzKRLGGSkspvZD0ND5oNaQ9OYd01ZDze5WsYIk
        tDCj6QDgJsc2Q+NrO/mOKJo=
X-Google-Smtp-Source: APXvYqy08if6BIYz4s0S8sls7ME/DjVJOt/8KFzpbGTHjKqQp6fP8BpXY7xdJv9jkWFc6+m2xp4NrA==
X-Received: by 2002:a63:d54f:: with SMTP id v15mr15919849pgi.64.1580059644107;
        Sun, 26 Jan 2020 09:27:24 -0800 (PST)
Received: from [192.168.1.173] (c-76-21-111-180.hsd1.ca.comcast.net. [76.21.111.180])
        by smtp.gmail.com with ESMTPSA id f13sm1548361pfk.64.2020.01.26.09.27.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 26 Jan 2020 09:27:23 -0800 (PST)
From:   Mark D Rustad <mrustad@gmail.com>
Message-Id: <8CC9FBA7-D464-4E58-8912-3E14A751D243@gmail.com>
Content-Type: multipart/signed;
        boundary="Apple-Mail=_776D8AFA-E24B-4D47-905A-F77CA0B5E5CF";
        protocol="application/pgp-signature";
        micalg=pgp-sha256
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: [PATCH v16] x86/split_lock: Enable split lock detection by kernel
Date:   Sun, 26 Jan 2020 09:27:20 -0800
In-Reply-To: <C3302B2F-177F-4C39-910E-EADBA9285DD0@intel.com>
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
References: <4E95BFAA-A115-4159-AA4F-6AAB548C6E6C@gmail.com>
 <C3302B2F-177F-4C39-910E-EADBA9285DD0@intel.com>
X-Mailer: Apple Mail (2.3445.104.11)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Apple-Mail=_776D8AFA-E24B-4D47-905A-F77CA0B5E5CF
Content-Transfer-Encoding: 8bit
Content-Type: text/plain;
	charset=utf-8;
	delsp=yes;
	format=flowed

On Jan 25, 2020, at 3:10 PM, Luck, Tony <tony.luck@intel.com> wrote:

> The “modes” here means the three option selectable by command line  
> option. Off/warn/fatal. Some earlier versions of this patch had a sysfs  
> interface to switch things around.
>
> Not whether we have the MSR enabled/disabled.

Ok. Thanks for the clarification.

--
Mark Rustad, MRustad@gmail.com

--Apple-Mail=_776D8AFA-E24B-4D47-905A-F77CA0B5E5CF
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - http://gpgtools.org

iQIzBAEBCAAdFiEE6ug8b0Wg+ULmnksNPA7/547j7m4FAl4ty/gACgkQPA7/547j
7m6voA/7BOHPo5FQZ1+9juQUZy023Dg8BA7YDVhFdsrJd6YK9zUFJAqDl1TFuJnM
Ylug8i/aEDScqqI20Kw5DjOQB5R7X3rbk8oJmFvENx0aSvFLejQ0qPuxz7CAfpnZ
nL7yJfBDf1GahLGlgqn7JXdhDjTqS2nxlYZLVodfJnUYOrXbp/+dkrkDbyMWA7Qc
Lb0Km5m34JmCthhDIPkdD4PQGl8tcRq4s/6jLdZWjAe28d5NPvi2lI2PgCnkm/cx
kM7s50X1LJS8Dll6T9Z4Fhze+L5uzSNOJ2/4ejP8jFb93/yb+3ZbctfcuvcUALhE
VOmisiz3hF7s1nf/VSMgj4R/ueEnVr5RLvFZEi3GjgKwGj996eFBK2RD00Td1zcO
datK8G+1D56RMXvobKqC9vkXeDP043SOotgFbI+8oJMMCfnrIoSvSKfR5+zoAELb
4IHKvWzMW79tpp9T1NMNQ/odBNJR1tw4LJd2pTVtHh9vWpQvTSVbr9mlBlbi3bKW
4myqxFzdR1jovstdAhubST/vBUbJXwudWpLV3LCNloJq8N4+1bKCrTnhA97ETvwK
TwZo9CYuw/D+Uu1tbJtO/P9C69I0HdbW4zlRb+xT+G3wgiK9HEY9hyV9HW0NAPmS
MnGakCdVVRwdJzCxfKbqhNBKpEeWggiKih5TLu2vroaZAtKOVXg=
=nlPA
-----END PGP SIGNATURE-----

--Apple-Mail=_776D8AFA-E24B-4D47-905A-F77CA0B5E5CF--
