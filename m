Return-Path: <SRS0=L1Qp=6D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B784C38A30
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Apr 2020 10:15:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 30746214AF
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Apr 2020 10:15:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="TNJ/SZf3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726112AbgDSKP6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 19 Apr 2020 06:15:58 -0400
Received: from mout.gmx.net ([212.227.17.20]:39385 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725914AbgDSKP5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Apr 2020 06:15:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1587291296;
        bh=UUB43ghojZyqJzvryIRz1INl9pLMh7p0IJbFf5QP2Es=;
        h=X-UI-Sender-Class:Date:From:To:Cc:Subject:References:In-Reply-To;
        b=TNJ/SZf3+4mTpQq09XvbEyvPAHJj8RbOs1bUbeVrvmWwhamx3wKM6Wwxg489RXSoX
         Tvb/kBsBy80uXtHp1ki78P50zlijkGMUM6XBBHX4XFd/armTBMemJRMkfOSJ9W0gja
         zyVuriMRIJVHaBb0VfoQTQAhKNVInzofhzLWz6w4=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from ubuntu ([83.52.229.196]) by mail.gmx.com (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MCKFu-1jZQeD43DG-009PuW; Sun, 19
 Apr 2020 12:14:56 +0200
Date:   Sun, 19 Apr 2020 12:14:53 +0200
From:   Oscar Carter <oscar.carter@gmx.com>
To:     Malcolm Priestley <tvboxspy@gmail.com>
Cc:     Oscar Carter <oscar.carter@gmx.com>,
        Forest Bond <forest@alittletooquiet.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Quentin Deslandes <quentin.deslandes@itdev.co.uk>,
        Amir Mahdi Ghorbanian <indigoomega021@gmail.com>,
        Stefano Brivio <sbrivio@redhat.com>,
        "John B. Wyatt IV" <jbwyatt4@gmail.com>,
        Colin Ian King <colin.king@canonical.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] staging: vt6656: Fix functions' documentation
Message-ID: <20200419101453.GB3244@ubuntu>
References: <20200418123659.4475-1-oscar.carter@gmx.com>
 <20200418123659.4475-3-oscar.carter@gmx.com>
 <adc4bc72-5c80-e8f4-8d48-052109ae18b7@gmail.com>
 <20200419074717.GA3244@ubuntu>
 <42190e0e-4167-3cd6-0e52-d240ae67a502@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42190e0e-4167-3cd6-0e52-d240ae67a502@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Provags-ID: V03:K1:uGVWodHyCTLdQ3XSyWqGBZ4gQuQDAHqGOos9oFi6KdRRLurA2TE
 /W+2OrlkPNeLluPXom2bihOZ14hvB6pWiAHLFLenr/3WGp2S336HJ5ruDal0aQUR7rztnTw
 f3VMb037pQIrOYptMrcdZNQQwVrGJmGsJ6jG7o0vRlqWOMjqeRQERobCJ6Cun2tRb4pfJuH
 Hb6Chks/Vf+S0eEwb4RZQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:i0sX5EJMf+I=:LUHt9YIF5DCp27j010j+Ig
 FhgIyn9jwz2q4dsefuegfy2wsFt0ctImsaTmMr6bqF8pWYARk57rok42ttTC8Qh1Yy9sbtrMg
 ihzXGYLDJBgEDD7OJjTsfnHkJVsjFVXS7BSDuUttu8GinuvsWs/WIzqpmY5zz2IkC0wR5rhom
 vkxRmJy0BU2uYAVk5iJjJdB9Nc+hcbDBoa/tqOJrTZ3pHNXi9fMb37spncRgzJVyOTCbbzgkN
 whIgfTO2MoSstXnfRdIsDuaIWDBL2Mi8zXATRjX8yGz4qUkVMIUYGD/PgzpalsmA7vig1nQUp
 FnE/cul4yLnny3hrxqX1KqBK7CPBYuJxFcuPTG3lMYOb7TQp2uO2pKlCLJiH80RSA79IZdedr
 CdjStDLrLaOaU8I3S/FrFPjVFcZg+cjSh7oFf0G3Pu7KXs9gPPc5NUCHGUkOa9Uuc0CmNpl2x
 cyCaf/VVvKIZ74loeN6+ariHNnExq9zctMPsSqCDI9jBrZV7D2XsQH9FNLDw3MCNmqMcBO1Oa
 8aY60w4SVYEjz+pCWkhkBkk/6uEBmZ/my0vErgetSsxE680ffmleUAtyCZSqYeM3fSksN6VyQ
 k9mHI5JbDpr5HqOAlnJUWMfdxmaCNG4zxzsSUBTR2V2BHJO0+brR2l68dT/eoD5LCTq1qwK87
 UXc7CD0eDv2V0QKVuV8XG77i2c1WHtbr1FWXVisfQoAeZdxY8JdMi3czYjRAicYv+mCxxT3P7
 w40C3BxcuttRDrHWmvzGRTXEhaFA+YYVbQyrjStpB39t+eYR7/AGqiEsUFE9roxUtD8FrRiUt
 tOTU1rhJFAmoSurqwoydx3y2zKorUsSc1cAt1yoVmkON57jOZP3xabwxkowPZpAYumGXG7q8I
 lRwE/37G7iOlyUVCa67r9Lb2ToWsx3He3XkE+RG9+jO6wwtWe4H8ogA3GkaU7stzU58ydDuzg
 EdW44xBRs/blD8nysJAa3XNfdXAMGU3n5LKaZNq1DwbgP8VTsEbq29PEXGhvyCDwrx6HgstFj
 eY5nY31S2zyWjDlQq56SgerOaDGTtQ/sylD28TYHT3NBxqvxhGPIf8skT7u2k9zdVmn14VCTt
 y4cF0GYeyG0Y2PBQVjzsyHgP4xSupg5pvW+CuevBQ+w3O5Z3cG91J/MTyX6xeFa3rTw2tpRzZ
 2ZPtJP9mbRYWbAvqTzqoObxbXUu9ls5GkVdVYUnTuMpB+ioWa97e0ALqAuGA3oHNWfTAriJ8M
 m7/JlmOW9JPCBd3e8
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 19, 2020 at 10:22:50AM +0100, Malcolm Priestley wrote:
>
>
> On 19/04/2020 08:47, Oscar Carter wrote:
> > On Sat, Apr 18, 2020 at 07:05:53PM +0100, Malcolm Priestley wrote:
> >> Actually I don't really think the function descriptions are needed at=
 all the
> >> names of the functions are enough.
> >>
> > Then, it would be better leave the documentation as it was before or r=
emove it?
> >
>
> I would remove them all except for comments inside functions.
>
Ok, then I make the suggested changes and send a new version serie.

> Regards
>
> Malcolm

Thanks,
Oscar Carter
