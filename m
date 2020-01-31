Return-Path: <SRS0=flzY=3U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15BA9C33CB7
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jan 2020 13:36:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC5D520705
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jan 2020 13:36:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1580477786;
	bh=36im6bznVr3VlhITe091kW2o8aBJr7dAtawFyqiBVVc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:List-ID:From;
	b=Se5WKUNyXopgZXcdYlNUfwEOCPkL0VJg+CcqlLuNj2XMkNcTknTU0Y2GXFAjt0wKt
	 JMU8OvtItwf41lI5ketjVzIdv5Tv4AYow3YLHxNbgCkQV4aGwgGnfZddTYLWXu7nVH
	 V8O2JTNOAEMas53kDJqdOaj9bcKvJz+m54S+IoOQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728821AbgAaNg0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Jan 2020 08:36:26 -0500
Received: from mail-lj1-f172.google.com ([209.85.208.172]:40707 "EHLO
        mail-lj1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728614AbgAaNgZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jan 2020 08:36:25 -0500
Received: by mail-lj1-f172.google.com with SMTP id n18so7093384ljo.7;
        Fri, 31 Jan 2020 05:36:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=36im6bznVr3VlhITe091kW2o8aBJr7dAtawFyqiBVVc=;
        b=aCgWyI54FFxymXQIxylsUJxHwJOzcvMk/eK3kXkaRxQUbLwqy7aA51PXmRG0vrmNdu
         K93Oz5gIeIiopw3F/E+0VjM54ZstePlZNcnLw5mhD+Y7bcSsalgiyiuO4Zfx9I/Iv/Lw
         a+O57/lv01X6ZXtROOF4NiOQeIILLCnBdgOx/pAfG4crT0ZFffiutPawQwfh3HtrPodJ
         SW/lIw+B+PPgALXnR0QiV1SuODqPAr4b6h7BNk0VWA9JkV2elmr6Rj5slkO8H9bQfANc
         YfXePRTFJ2YqY/Nx30dr12Td1rMCPS1DWMTrmFciMVCfm5Sv9rzi20sy57Fnv7OasVLa
         ttTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:in-reply-to:references
         :date:message-id:mime-version;
        bh=36im6bznVr3VlhITe091kW2o8aBJr7dAtawFyqiBVVc=;
        b=mUFA+5VyBWppgAB5tQVixEZlYd3DLdJqUNG18nL79IKRBAZBPx15vNO8kAFwnWT+ea
         scWZHDU6Ne/G+SVm5ui3U4LqoTMElbfov0oBLgbSi+zIvXWPStz/CJZFbZlKmE5dY9J6
         dlFg8KwzjWN5qnRhgutJ3OizQlQAOFaaFrM4dYqhcrotYLJywiM55Q7MrVaPIktg4VhY
         ELEs6WEJrFG0JFcEgFwnDv8BtLeUzC32nWeRSKoG96UFHYLJ9LfzQIKNPryMosY6NJiT
         lrcOOZ4E+zhjEuSca8uNvByXHlIYFDGo1K+agPbbeRiiDdWbzzNWhL+HqchwT5HYoodk
         pzQg==
X-Gm-Message-State: APjAAAVPyN5W1IXlJX/x0Pdr+TSKD2BQ89EOhplKFMIiAtA+1Y1mpnZy
        3LgZJHh7/8QV+5TV2+C1VTk=
X-Google-Smtp-Source: APXvYqy9SXfc4Ak9UEw8yYRMtjd1zHNdFzILr7FF5HWU+feIs3Zgjdp34mjDT2MiG1qbVqC08wXeEA==
X-Received: by 2002:a2e:8944:: with SMTP id b4mr6106832ljk.90.1580477783171;
        Fri, 31 Jan 2020 05:36:23 -0800 (PST)
Received: from saruman (88-113-215-33.elisa-laajakaista.fi. [88.113.215.33])
        by smtp.gmail.com with ESMTPSA id f21sm2901282ljc.30.2020.01.31.05.36.21
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 31 Jan 2020 05:36:22 -0800 (PST)
From:   Felipe Balbi <balbi@kernel.org>
To:     Amelie Delaunay <amelie.delaunay@st.com>,
        Minas Harutyunyan <hminas@synopsys.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        Fabrice Gasnier <fabrice.gasnier@st.com>,
        Benjamin Gaignard <benjamin.gaignard@st.com>,
        Amelie Delaunay <amelie.delaunay@st.com>
Subject: Re: [PATCH v3 1/2] dt-bindings: usb: dwc2: add support for STM32MP15 SoCs USB OTG HS and FS
In-Reply-To: <20200124084131.23749-2-amelie.delaunay@st.com>
References: <20200124084131.23749-1-amelie.delaunay@st.com> <20200124084131.23749-2-amelie.delaunay@st.com>
Date:   Fri, 31 Jan 2020 15:36:17 +0200
Message-ID: <87imkr7nou.fsf@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha256; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable


Hi,

Amelie Delaunay <amelie.delaunay@st.com> writes:

> Add the specific compatible string for the DWC2 IP found in the STM32MP15
> SoCs.
> STM32MP15 SoCs uses sensing comparators to detect Vbus valid levels and
> ID pin state. usb33d-supply described the regulator supplying Vbus and ID
> sensing comparators.
>
> Signed-off-by: Amelie Delaunay <amelie.delaunay@st.com>

This doesn't apply. dwc2 bindings is still in .txt format. I have taken
patch 2, though.

=2D-=20
balbi

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEElLzh7wn96CXwjh2IzL64meEamQYFAl40LVEACgkQzL64meEa
mQZIPQ/+PCvVhKhlTWv/YRoBCIDmZrvMR7z4BnhSOWmy8BihbEU5X7F+qo3P+VyY
Gw/us6ppE93yom8f5mljaKlLrB1nWhVa8EU3wq3kFSDgIcMZ1HV8zBWDhqDClcN7
SG/fImL0IxTTf9SDhPiNU+Kj+MfUMuwMmoIcvqDfoWtM9lR/9JDWOPfzTHYWl6Qv
5zkxOrMuTA4z+/yYQpwXsmQxUQnywhhgN8AHmFCeXtnO+AsdutFJHM52Pp8XXW7I
s6SMdX0/EaC8IFCxLXYIdRw1agHTDwf5EqtML1d9pVrgZzGC4wcknDwWZMwvRTha
YXNRFPiQ6bqzeT7RJPRpxBtoYZDXxBNXQ/cqVt+FTiv3G+xYiVW97Sj1+fwIC7/0
T/A01s7frHhCnJM5pDErhoJW0aq5BmesgxW2AhyY/M+mXlGbjcKCKDWahAuhf0Cx
s4em3gwLACNvw1Ztp1sv/BvRAE81QMt9+m9PI5pZu8IVU6PpIb1jQBsvgu6POoYc
9FIhAqYKYuzIgF1p7z3ee2c7+14IwJl1br5P6Xyx81IeS0gna8v+vicErSPCt+On
r8VDIjv5dknh5IoQfO/+q59f8mp3e2XdVB6pZYTwsJu2i1nK6Afy/jVCJICw1I+a
7FD6QaprCNakl/Zbfv8wJUQaKbCChpZEV3gNL1lzNinIG6b2KDc=
=QKjo
-----END PGP SIGNATURE-----
--=-=-=--
