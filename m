Return-Path: <SRS0=Rqeb=BC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68DEFC433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 09:19:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 42F16206F4
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 09:19:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595495984;
	bh=BOivF0+hGJhapK/ON1XkDHe5Mt2w6m5Jdl3CnxjGVLA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:List-ID:From;
	b=zzXyxY/1K6Tk8ee0+K+J2PfP/D2HTaIF2tQqQGB1oUZl1AjUkUtNTrj+XL4SwLiCx
	 fOdAHTNKILyBrUmZyKQm0q3E5vTXz1NENfvaQDikgDz/DGWH5OZULH7ejYgzkR9AkR
	 nXmMa48K3m+lK1OHWivu8DhnZSj+/MNy2zyKa/k8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728159AbgGWJTn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jul 2020 05:19:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725984AbgGWJTm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jul 2020 05:19:42 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59E7BC0619DC;
        Thu, 23 Jul 2020 02:19:42 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id z24so5559031ljn.8;
        Thu, 23 Jul 2020 02:19:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=egzvAcS1tlpnyr8NTaKNeBNSJi79VYExYu7brjMWOkw=;
        b=o3IT/Gs0M+qmPVdsObIgYdquRbgOmoKX5wLA2XoJy55hjs/BJJDM+7PV0LcwzdT7//
         tLA5njhXiPo+9A4A2FfNaGJbdv4OdxE0eiSqsX6jCZRAvGgPaI+OkdyckF50s3g8sCn/
         zbmr9WjioIH7XXkaFekKqdqqeD+kmb/pmFHX2MIKXv0knDQKPwMBhAFwY8gqcweCExjn
         IsrnHlxeZ37ob3RCEDNibnO93Nt/cAzxnmoRpzhFSDZCDhkzbphfJBqXLce3/MbvKn3m
         fh2uStTmmTJK+qKvTcIZTR17N4Y5Oo8hsx+drxFkksUXUBFxd1ZNrvmAnHw9jU5EGHDw
         QIZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:in-reply-to:references
         :date:message-id:mime-version;
        bh=egzvAcS1tlpnyr8NTaKNeBNSJi79VYExYu7brjMWOkw=;
        b=ET46mIjoZIv1yNCR6H2gS8IGCktckU2W3WnBIX57C/zhMORNOd+MTyLafQ9gd6uneC
         tjCZr7vR6mJGKtJXuPKynhefsLxWxNX/2s0sBOKsNS2PTecLfJvgYqEHaahCHQYY8aNo
         ALhSKL1XJITJZqRwvN5dPsHOlgeoWfmzjLCNKOXDggFS12I/shGrgnICc3o0eppUE25x
         0pUDaGMbDOsg4S9y7/HxW9NstZPMcAsOXl6/pS/8GeM2dwyyIcb0qis0o2qj8/1yRy0g
         NkVnfvY3YtBtxICPRs3b2B0QicY4m36rw9rtdxj0UDZ7dPzIQdmICOciQyYko6ZiaOAm
         Kn1A==
X-Gm-Message-State: AOAM532kCkgVCmHGvwKaw/Jk/Udjp39R8VDoh5FgijwE0KmX+FEh5V5I
        WkYWWvUgYblgJOQIGIZKkQ4=
X-Google-Smtp-Source: ABdhPJwdK1GnIWfp3HJK28OU8/4dCOOMCMxgjN8ZoCEBgYc1rQBMR6GOmmpqMCoL5l+38sOZeR0u5w==
X-Received: by 2002:a2e:3316:: with SMTP id d22mr1617480ljc.18.1595495980761;
        Thu, 23 Jul 2020 02:19:40 -0700 (PDT)
Received: from saruman (91-155-214-58.elisa-laajakaista.fi. [91.155.214.58])
        by smtp.gmail.com with ESMTPSA id l1sm2233581ljc.65.2020.07.23.02.19.39
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 23 Jul 2020 02:19:40 -0700 (PDT)
From:   Felipe Balbi <balbi@kernel.org>
To:     =?utf-8?B?5ZGo55Cw5p2wIChaaG91IFlhbmppZSk=?= 
        <zhouyanjie@wanyeetech.com>, gregkh@linuxfoundation.org,
        robh+dt@kernel.org
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, paul@crapouillou.net,
        prasannatsmkumar@gmail.com, dongsheng.qiu@ingenic.com,
        aric.pzqi@ingenic.com, rick.tyliu@ingenic.com,
        yanfei.li@ingenic.com, sernia.zhou@foxmail.com,
        zhenwenjin@gmail.com
Subject: Re: [PATCH v5 0/4] Add USB PHY support for new Ingenic SoCs.
In-Reply-To: <20200723061301.82583-1-zhouyanjie@wanyeetech.com>
References: <20200723061301.82583-1-zhouyanjie@wanyeetech.com>
Date:   Thu, 23 Jul 2020 12:19:35 +0300
Message-ID: <87tuxyoafs.fsf@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha256; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

=E5=91=A8=E7=90=B0=E6=9D=B0 (Zhou Yanjie) <zhouyanjie@wanyeetech.com> write=
s:

> 1.separate the adjustments to the code style into
>   a separate patch.
> 2.Modify the help message, make it more future-proof.
> 3.Drop the unnecessary comment about hardware reset.
> 4.Create 'soc_info' structures instead having ID_* as platform data.

For v5.10, make sure to move your phy driver to drivers/phy.

=2D-=20
balbi

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEElLzh7wn96CXwjh2IzL64meEamQYFAl8ZVicACgkQzL64meEa
mQYrexAAjbdELMxCC4r2JHaPxD4SqSWarJFRJWmNBjtsxTH0zHvO1U4dYKzJnVyt
0mAI/ubtts0W2Ge5GOSBbOcIsExUZdsQ/H/eN+OhAUZIK23ucxtliOGLrdGKIHks
hb1bYSn7QzKFilCo0tFj004x/6IdhC513koISGbac35fDDN2sDpA6aQ5kYLeGb0n
hF9D22KroIQ2NElgr/XoZV0udzzPofL7I0RIjGHSTM6R6KBbUUSnFSiiTzDxffBo
bt6K23X4jQHtpQ9Gv8uJV8VgAY1S2HhFSTdvXjOCrZ4KWzxBpvtTKtamgGpi52r3
NPZh90IacEY2soZfLJnem0OWB2RKhegyNbx0pJ51ZMVB9S/EGzOsItCkuZPi/TJW
osaVCaj+m+Z/4AWhDyioglJi5zaR9FUzp30zWALwyjsAOCFcAv8Odn9u/5qqXeW2
KVwpxE1Pc3vR2aoSg+II2gxZL/vS8yyntUywkEBselgTzXGJBAvZdhitrmjabIxu
tV1w3o4ymr6J3hpdOrg4/kXUicFonHdMymqCqmAJFywcJ6r410RUDH19y1HxvF5y
q2hPXMf80UR0ZHg1W8yIEWG3fMWuYHE0oc0kTsygnDVrfwGwKmdWPCZAN1w7zEMW
tNk5KsjQ9PEo/auti8vXkOMPvSBWvVrIXkJu6V7Wf/SPlcii9Zk=
=3inY
-----END PGP SIGNATURE-----
--=-=-=--
