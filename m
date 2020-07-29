Return-Path: <SRS0=g5yc=BI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8317CC433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 00:28:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4F1DD2078E
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 00:28:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=crapouillou.net header.i=@crapouillou.net header.b="EfEwEftY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730651AbgG2A2N (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jul 2020 20:28:13 -0400
Received: from crapouillou.net ([89.234.176.41]:57238 "EHLO crapouillou.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730300AbgG2A2N (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jul 2020 20:28:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1595982490; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=D7K8xJ2GrVdOEj3CqIL5oCfQGtlYpiueUM/D6mIsibQ=;
        b=EfEwEftYNWn0vlIz9rfuvRDfyKMPGKP7oR0wBEcDXrAmrEdzvrVAdNIOGeHn6Ii6kJ+qJG
        0aJX0ayayjpLoklQNZqW07om2Xd9xB7HaGoGCK/kzo2PBrjG+Spq3tSXkBZgGm3DOXkFOb
        D0J1yqvb7y92aVeZ20BvlA+IgDPgF0k=
Date:   Wed, 29 Jul 2020 02:28:01 +0200
From:   Paul Cercueil <paul@crapouillou.net>
Subject: Re: [PATCH 0/2] Small cleanups to ingenic-drm driver
To:     daniel@ffwll.ch
Cc:     David Airlie <airlied@linux.ie>, od@zcrc.me,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Message-Id: <PYF7EQ.CC652MXUV2R41@crapouillou.net>
In-Reply-To: <20200728220008.GI6419@phenom.ffwll.local>
References: <20200728151641.26124-1-paul@crapouillou.net>
        <20200728201736.GA1277651@ravnborg.org>
        <20200728220008.GI6419@phenom.ffwll.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Le mer. 29 juil. 2020 =E0 0:00, daniel@ffwll.ch a =E9crit :
> On Tue, Jul 28, 2020 at 10:17:36PM +0200, Sam Ravnborg wrote:
>>  Hi Paul.
>>=20
>>  On Tue, Jul 28, 2020 at 05:16:39PM +0200, Paul Cercueil wrote:
>>  > Here are a few cleanups to the ingenic-drm driver.
>>  > - some error paths were missing and have been added;
>>  > - the mode validation has been moved to the .mode_valid helper=20
>> callback.
>>  >
>>  > Cheers,
>>  > -Paul
>>  >
>>  > Paul Cercueil (2):
>>  >   drm/ingenic: Handle errors of drm_atomic_get_plane_state
>>  >   drm/ingenic: Validate mode in a .mode_valid callback
>>=20
>>  Both looks fine, you can add my:
>>  Reviewed-by: Sam Ravnborg <sam@ravnborg.org>
>>=20
>>  I assume you will apply the patches.
>>  Maybe wait for Daniel to take a look, he had some feedback on where
>>  to add checks. I assume this is covered by the second patch.
>=20
> Yeah changelog for new versions would be great, but aside from that
> bickering patch 2 lgtm now.

This patchset is V1, I'm fixing issues you saw in the ingenic-drm=20
driver when reviewing a different patchset.

Thanks for the review, I'll apply now.

-Paul
>=20


