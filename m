Return-Path: <SRS0=flm+=CO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A409FC433E2
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Sep 2020 18:41:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6E1332074D
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Sep 2020 18:41:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="ECxkn2Yj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728470AbgIESlx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 5 Sep 2020 14:41:53 -0400
Received: from mout.gmx.net ([212.227.15.15]:44853 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728393AbgIESlw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Sep 2020 14:41:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1599331303;
        bh=0Z88wMNKjODEhVbrLNthLoTct+0CZsnhohBGameaszE=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
        b=ECxkn2YjdfbF29gd53eH8o1kZ7xAMiQKgRFt1LjkuTrAJ/rO39No0bNl5hDsDdYzA
         Q/W3S614NwQlO8OgCG/f8jrHNMF0z5JlHxvOrC7yGDktKBQZ7N/x+Q8SEtVyl+UT7Q
         iUPYsf2hHx1nKtYRlJaKU+QXiFv11LxX1QPcSfrQ=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from longitude ([5.146.195.151]) by mail.gmx.com (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MhU9Z-1kiRds1ZKt-00earg; Sat, 05
 Sep 2020 20:41:43 +0200
From:   =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
To:     linux-doc@vger.kernel.org
Cc:     =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        Jonathan Corbet <corbet@lwn.net>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Hans de Goede <hdegoede@redhat.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] docs: driver-api: firmware: fallback-mechanisms: Fix rendering of bullet point
Date:   Sat,  5 Sep 2020 20:41:30 +0200
Message-Id: <20200905184131.1280337-1-j.neuschaefer@gmx.net>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Is+1nVBMCodTpEsmt6XDtWrHb47bnhd0gIpCFGj05LxIx/Lv8T7
 Kl11NsLhbIdYylI/M9uKrA5wLPpvnf4SLIiPpSNoq6ppXQg6rBBJNa2cOsuln1y0JumJJq9
 FDnIioBV5l1BFCKBwRedVPAzsuOBU8CTxurSsEgGVrN3wgoBaSf4UOLvLojv6KjVhyITG6r
 HpMV9svnV//KW0H+Gd/nw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:TKxAAmXorPQ=:IPm5oaR4gjs+SdWvqmZhRZ
 0bQbZyUSX+CqzVsuGGK9eCvi0YscAwFyGIN5xNZaqHfNMJKgA9Ox1nNrxdrD0Yf4N3LCG8gOx
 WQF0ZoiDVrsfazCEoK6YsMaLwYp5hq2NbR7p7sr4WYfQJn1I5ubZoaz5BuTQhZludGtBNQIkW
 9lnbHAz5uEfR2Con/bYAJHw9XH1UOsO2Iv+1xoBw7c/zgM0NkqAzBYXcEAvAG9K6pJ3OHzw8V
 ovg+kgRXeoz4ju8H5I/X1AY6qwIoRg+jIPljczoG/geIBs+mB2az7vNkqHj/rrF3gEB2qyzwF
 4e/+5y4zMNzXRkNhWoQHALhoa7Rp1DuP26UrPLawceJG8KD8g3XYLei2uLS9wRMUDDUnYK83M
 yC2RioWAE6DfhM4UuAlOXk9v+T58BIiGq6TAP5qysdqXVlI91pt8OuQgYGs5/nPD7pvMCC6Mf
 ULLeKa36PQGfslPxM2sTSI7vx/Bj2bypW+IW7Q/tY9n1i7lVDB3OWbNENVv8vZSpEEIHb5bvz
 Es0cFLsWIGK+6d2ZzhryTaUEr9ySM+GV3z+vwx0MqiDxjda0ey5AZWqKKbHscNhWfuJsKJ2j8
 cvnxUrli94uUeNskMX3ppN6CYe0X5Rgwvj5bajpxK8TW5MHb6zLSUBfrgyHV4zI/KOdMvTW8F
 yRwiyJLEidUf3LIij46zIZnLytJC2BxNk4a0/HbdXWZUcJNWWtfKdPmwN0JU67LH4GcCHFEZl
 1oxGFNdCLO+0XimdTuFI22jhkSyIl3AM9JNLv5b00MfrzjRai5d1eukKx5DYoKKWSc8Ix6pRh
 iQvRbiEcgF0O5bIsFUGYVGVR3oAXFTlhCozweKJefArA67buGUSCWerPLnIpo/M5jIvkz85Kl
 v28gNTLAGQDbH3hrgogb1DxkuQYnK6q33wQz8FYjk6CmkipyXt16oS8kEqLIvBntYtvVxQqrn
 aKXiqrQPH84h7CW80VJp5CdkWmpcXDzURYT9DtPxRX6lXBfzqgSylikswqB2uiC/+0tKgxZWU
 0VhMdO7Q/SlkhN5BdoxuQUlW3I3hTqUp2bZzSgBmWvC784QUsTrQnEsIu7ysscRDGrHyqOljK
 ksLTawTKdTHnBIXerazD87BHSw25AjqaPvfQSLaJFcq7w62/BBKl1K8kn6Dh40qEulBedoiTc
 yXk3eYxWyiVPlGIJ7wR3Bivgog/Ik6FrUxGieem8v3o6uRKhz0f2iQCrkbdTO2skHyQCVx0iU
 8GjjQcRHs05bC5zIV6jYV+yJPwxFCNbhKig4iMQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Without this patch, the "Firmware is not accessible [...]" line is
rendered in bold, which does not seem intentional.

Signed-off-by: Jonathan Neusch=C3=A4fer <j.neuschaefer@gmx.net>
=2D--
 Documentation/driver-api/firmware/fallback-mechanisms.rst | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/driver-api/firmware/fallback-mechanisms.rst b/D=
ocumentation/driver-api/firmware/fallback-mechanisms.rst
index 036383dad6d66..5f04c3bcdf0c5 100644
=2D-- a/Documentation/driver-api/firmware/fallback-mechanisms.rst
+++ b/Documentation/driver-api/firmware/fallback-mechanisms.rst
@@ -42,6 +42,7 @@ fallback mechanism:
   supported for request_firmware_into_buf().

 * Firmware is not accessible through typical means:
+
         * It cannot be installed into the root filesystem
         * The firmware provides very unique device specific data tailored=
 for
           the unit gathered with local information. An example is calibra=
tion
=2D-
2.28.0

