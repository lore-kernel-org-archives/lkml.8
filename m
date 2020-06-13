Return-Path: <SRS0=WLRa=72=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6EA9C433E0
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Jun 2020 16:29:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B53A0207FF
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Jun 2020 16:29:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.ca header.i=@yahoo.ca header.b="Mln2l7Ad"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726517AbgFMQZb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 13 Jun 2020 12:25:31 -0400
Received: from sonic314-19.consmr.mail.gq1.yahoo.com ([98.137.69.82]:40556
        "EHLO sonic314-19.consmr.mail.gq1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726361AbgFMQZa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Jun 2020 12:25:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.ca; s=s2048; t=1592065529; bh=pNotLi7DF8cvryO1AMRC3RkC85TH9IyZvCyVFgZyRKM=; h=Date:From:Subject:To:Cc:References:In-Reply-To:From:Subject; b=Mln2l7Ad7YZepIuP6YgQ3/GaRew+KD5QROGR5a5f1XFth9K2KykxZgdQIY1kf2t4+mmO0mdg0wpyUDSQkUHxlMG9YJ/31WuTxrqwQEQ3O61VcU8eAyiaiS9hGu9tfVYhfSC/mr1dQqD37GqzAltjNjLFGx0ZAWzvPUhDZvI7YXj+ElFkyvkZ0kTR7b1PtItGT9H0De8P7lHXd733tijABsDPHtiTMpudKRea5oYq2kU6n+S7yi1hlIzL2zqHCgYD5FpFXvPMv6RBh1QXXhedgJOL4nrcyCA7sIXD5aqxZO9hgYudrG4pmeUMYEpDJ//NfXq6TANTaChrt4CqrbOVkg==
X-YMail-OSG: 6xZy4LwVM1nd_259LUsfr7ESXnJPNKXe.ums2_AeYGD5E4s8Y7CFF3Mm0dlpGL6
 SfAqUPtj.6O4h0KPuMkapZzV2YEEZqxdvlBbmQY5IgO.XLSktsOJju86dPFl_z6JZZv7nTsHNyEu
 RtyIrU3KvpqBFgKZFq3Q3ld6C94J1qqBHxnQVnkJy_cpuCsjhQfiwGo69kFu2PqtghvhM.35Py0j
 Hdc01wdIN7Anj55dhcDi9r328.qgTmoLYD1yY6T6Ma4rt87TvevKii_LsVxC7vV5awFpTy92V0qB
 xA4uF.cuHwwpgKzs9NA5mciWh_nRniSE1wi8pAkLHCZL4LeQiWr1YCm5N8QYWtkPwAFoxtoa615E
 4uVIB88zfGooRG7gsxXvfmXz55uk.kcW0vgcrgYAv9Demk7HJwIv5c7IlfVolQ2Eg49onAYhU1rc
 9aMcycnwd.TZdfOwNPTyWyp5RHRAALlUkultoB1qogAN5kMZM8gZTFoqlCUnDEITnoFMkk72FHvk
 kCTSXc4_PaujrVLtFpi8mBXAxMlrRgef..K.ZFt00T1SefVsfxov3kxZBL1sFGDL6a4_we3Deudj
 5VbrijJK7ZH7sv4ht7ev1TS92JHIGdJectp7cOQqeqhhwifMzwaK7ElQhJsn4KtJMUl2J3iw.6Mk
 KeqKekJQyb8DGN9xtBhIVBSoz3N.qIiEcrZSU5nfK7c8pYbnZSP2kcwBMM2VUPYgCA3dze.NUAg_
 o.5_l36UEEA5RhtgnbnCzsuIbD7puNHXQTvamL0vjtdWytu4n_Scaai0ALdgmy9FjLt.ogsj7eYd
 oQuW6KYXbRlTuxQqs0Al7F8eqsBhcThd_b8AX3_7vfx7d9SW6OL4izC6ttqiE.SY4EJWhK_nxxB4
 Rl4PPaE1DvxWjnZJHy5I92b51qYAcoh5W35.G6uSlhiDAxn_EB_a8rn3Q7QZl.K4iEd5TzLBqMN9
 hTxJviNdfk67hahEZJxKQrixQh78FNrbXuqQm.yFhVR2Gvi1K2co2i4UoOvW_8tAZIHV_ddPrT86
 VxAVfjXgdFCt4gOXgnIsa2Uq79udcnlITAN5aYyIPA0Xy7BGQ1tb8I8Vt9BLDLyWaKpOutUGadml
 t01mTxfa2m9cTK9Vmqb2isYOEovslcfW3oYqChkMLoZfqE2hffuy7BJ88i0HQzjZTaJYXXhJjvOR
 qWZ_GApsAXA.yxHEIBuVki9r7knDBi6EGDZHYbxhrX2b35c21Xx8uY9KvICO1ILr5EI7oiuq2Wy9
 CWGRQy7vA9GphQHXzYy4Ybr2LapuHhOXAkrifNx.I8PWw5m1WW75SoFH8.B.A.4r3hQYSCN_EFsr
 8w._oJKurpcb4mLBsizZIrPlCb7RgW2.LgsbkcjQbbTl4ZL6VZlh3545_80VMBP6vIGqR86i6snW
 ZNOzAQ0wwDqjtu690wQ--
Received: from sonic.gate.mail.ne1.yahoo.com by sonic314.consmr.mail.gq1.yahoo.com with HTTP; Sat, 13 Jun 2020 16:25:29 +0000
Received: by smtp416.mail.ne1.yahoo.com (VZM Hermes SMTP Server) with ESMTPA ID 94fb7ac0c14fd50d6292d63c31f7e5c3;
          Sat, 13 Jun 2020 16:25:26 +0000 (UTC)
Date:   Sat, 13 Jun 2020 12:25:22 -0400
From:   "Alex Xu (Hello71)" <alex_y_xu@yahoo.ca>
Subject: Re: next-0519 on thinkpad x60: sound related? window manager crash
To:     Takashi Iwai <tiwai@suse.de>
Cc:     alsa-devel@alsa-project.org, bp@alien8.de, hch@infradead.org,
        Christoph Hellwig <hch@lst.de>, hpa@zytor.com,
        linux-kernel@vger.kernel.org, mingo@redhat.com,
        Pavel Machek <pavel@ucw.cz>, perex@perex.cz,
        rientjes@google.com, tglx@linutronix.de, tiwai@suse.com,
        x86@kernel.org
References: <20200520111136.GA3802@amd>
        <1591545088.74ii116nf2.none@localhost> <20200608061950.GA17476@lst.de>
        <1591624340.z01ejtod28.none@localhost> <20200609114733.GA1621@lst.de>
        <s5hr1uogtna.wl-tiwai@suse.de> <s5h8sgtede5.wl-tiwai@suse.de>
In-Reply-To: <s5h8sgtede5.wl-tiwai@suse.de>
MIME-Version: 1.0
Message-Id: <1592065395.r5zwoblr15.none@localhost>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Mailer: WebService/1.1.16119 hermes_yahoo Apache-HttpAsyncClient/4.1.4 (Java/11.0.6)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Excerpts from Takashi Iwai's message of June 11, 2020 1:11 pm:
> Thanks, so something still missing in the mmap handling, I guess.
>=20
> I've worked on two different branches for potential fixes of your
> problems.  Could you test topic/dma-fix and topic/dma-fix2 branches?
>   git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git
> Just pull one of them onto Linus' git HEAD.
>=20
> I guess we'll go with David's new patch, but still it's interesting
> whether my changes do anything good actually.
>=20
>=20
> Takashi
>=20

On torvalds 623f6dc593, topic/dma-fix causes sound to be output as=20
alternating half-second bursts of noise and a few seconds of silence.=20
topic/dma-fix2 appears to work properly.

Thanks,
Alex.
