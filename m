Return-Path: <SRS0=NqQd=7Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55AC5C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 14:52:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 312C52075E
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 14:52:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.ca header.i=@yahoo.ca header.b="ZuOuu6dU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728408AbgFKOwH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Jun 2020 10:52:07 -0400
Received: from sonic317-20.consmr.mail.gq1.yahoo.com ([98.137.66.146]:40872
        "EHLO sonic317-20.consmr.mail.gq1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728280AbgFKOwD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Jun 2020 10:52:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.ca; s=s2048; t=1591887122; bh=KZU41mzjo8YhkM4cekdJ5/j1xc6nz7kyQqQpnnzbcmA=; h=Date:From:Subject:To:Cc:References:In-Reply-To:From:Subject; b=ZuOuu6dUpQDDGD1eJuy1x6yzaxy4+3GGnjKcwe4ySKIW7X1UFh3DqcJwI8CDmD6f9+OEhc9qRilN8m6axjg/N8/mjYSYGqp2YT47BL3SgC+fWbMC3xY1J1uosrgM7XC2LL2uLa10cSuiZCFwW/xw2LA+K6tDZXRIT6q6qwAdxao4WUZTmNa5HVwWY1js/blPfFPGTI3KEiDK+TEXh1DJavJ3KDVStPDIm9NBOXUPEFca6b0OSUMNI3dVYcBojpWkyJ4Y5R8Y31REZYKonw6HsGvWkaHRrjMEiEP0qMT9jot5XYLvh/mTxw7FdQc1y3C9qovIpRNaCoIfOJAQpJlfVg==
X-YMail-OSG: D_RezpgVM1kBJKU4ltGuI9yc3kvCcDxIanMilqIDEkDmr39qh6mGQZWYR.AngMt
 PSwfxTPrYoBF_nfX36oVMWVuYiyILG0kTloVnBdLuY_1amPJWN8oIMXsoaiIf0dZam7wDkSoNLrm
 yyiTHH_DJDpyQA3DUN2aEVZqJ8qqf8P0DDCTAuVUhYWHEQ0Vo9pfCXbmq2jU9RsV7b9_lSc66WtC
 K2adlOfSGaa0X6AyxL7aYuX9ItmScfT1wKecDTF9.vVitykqDsKwIW.xihUEz9D1NekAqGUNpEN6
 ebohSnxSLXa.iC0VjczSIS.tQowTny8_BojzZ1aECPwR1muYkZ2HbfDMcW8P4Sms3BH4XWH8sOug
 HhBjb4fHcGpj6hBHJp5ofnVqwDRr94HLwPw_bbV7rcOiXLefg7Tx3lEwk.arStYu.ZkguRZhdEUB
 rxPMmI1.jboAulkng.6ikMlajyDhBxb24bePIVA9MoVxXsBe0mcpVMify0ADXCj7y5SKDnuDqoul
 r2Z.UgYLSV.QDFDiolv4Z7afoRnhMxipfb7fjzNTPkycayhVf4S8WHkHyKQCUhap1uJU409chVSD
 hYc8AWxSp71pZFiZ7Hedwwegg36nd4wCw_f.dbQJSPGk_luOmAA7nZFEn3G5VOAhzg57F.vZ7J99
 c1LOwIW63cp2nQrnbK99VliGPgyh5G58FzmPHLu2LOWJ3sEtrhCJNAPWMN4K2oc8WTZOEXVgj7Rh
 vpTCYhhpWqNTFf1bvwD9ux_uNJ5aGw7ib5q3ARHd1dPKbh7cSxoKZ_UzgAUX.U7jzODouZlrKlUu
 0j14MnwvSQZnXY9.0toSE4vt1reYw5U4OGnU2pwEiby6e2CgNzhwAsUq.xs5LLKOgsB8sO00F2n.
 wTmvUCm92m1TtBJ59lCGJ8abJSU2UiS9rTmyOdJ5QDlxxABxBNJOeqLiq4E21iPCRkVYOBRUbTCH
 YhoPd5eeB25UY3gKIQsi.PC5ZiGBpzBB7Nz_A17nBOlp_g9_lVuzOxJVxd9X3ttsw4twPcBR0MNp
 mQ11D.var4bz4SC0qhtIs3SxgVo36CYS7UrMtknBDYgMc9Cmz11tpzW_8IUrXQ1Di.bdibSLrUNl
 tjpczYgtQp3ADNNdFaeSdvipqMtvPL0mqANHu2qxdcHq8zU_Qoo5.jJFcvXHELlX5C0EmRYvPsaU
 _TAjOW6p.ith4GQ.8ANBDGiHdfD_OKX6PxiRH9JeNDpWzdiPW6fEo_bT4QJvPr5RKqhK6QtUp822
 X027OExABVatvCz.rVEQQUaBpjHpWW2KZPKrXdVMRcVfH.Rqu7Qce4vYjtHFW37hL46CxGFIwQsF
 .PEy15ES3flyyEt2C6HwqTbKvG035Wl4F60QTM406KGP5vJBUqy_n1G156Yo.dxl7Xp4TcHlCXB8
 FSid8v7NTs1uoYZmgvQ--
Received: from sonic.gate.mail.ne1.yahoo.com by sonic317.consmr.mail.gq1.yahoo.com with HTTP; Thu, 11 Jun 2020 14:52:02 +0000
Received: by smtp431.mail.gq1.yahoo.com (VZM Hermes SMTP Server) with ESMTPA ID 6c780120874f2799e5b2cd41953912c9;
          Thu, 11 Jun 2020 14:51:59 +0000 (UTC)
Date:   Thu, 11 Jun 2020 10:51:55 -0400
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
        <s5hr1uogtna.wl-tiwai@suse.de>
In-Reply-To: <<s5hr1uogtna.wl-tiwai@suse.de>
MIME-Version: 1.0
Message-Id: <1591885264.uk6f214o4o.none@localhost>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Mailer: WebService/1.1.16072 hermes_yahoo Apache-HttpAsyncClient/4.1.4 (Java/11.0.6)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Excerpts from Takashi Iwai's message of June 9, 2020 11:12 am:
> On Tue, 09 Jun 2020 13:47:33 +0200,
> Christoph Hellwig wrote:
>>=20
>> Alex, can you try this patch?
>=20
> Also could you check whether just papering over the memset() call
> alone avoids the crash like below?  For PulseAudio and dmix/dsnoop,
> it's the only code path that accesses the vmapped buffer, I believe.
>=20
> If this works more or less, I'll cook a more comprehensive fix.
>=20
>=20
> thanks,
>=20
> Takashi
>=20
> --- a/sound/core/pcm_native.c
> +++ b/sound/core/pcm_native.c
> @@ -754,9 +754,11 @@ static int snd_pcm_hw_params(struct snd_pcm_substrea=
m *substream,
>  	while (runtime->boundary * 2 <=3D LONG_MAX - runtime->buffer_size)
>  		runtime->boundary *=3D 2;
> =20
> +#if 0
>  	/* clear the buffer for avoiding possible kernel info leaks */
>  	if (runtime->dma_area && !substream->ops->copy_user)
>  		memset(runtime->dma_area, 0, runtime->dma_bytes);
> +#endif
> =20
>  	snd_pcm_timer_resolution_change(substream);
>  	snd_pcm_set_state(substream, SNDRV_PCM_STATE_SETUP);
>=20

Sorry, this patch doesn't work for me with SME off using abfbb29297c2.=20
David's newest submitted patch works for me, which I already replied to=20
separately.

Thanks,
Alex.
