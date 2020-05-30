Return-Path: <SRS0=qKPt=7M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC8B2C433E0
	for <linux-kernel@archiver.kernel.org>; Sat, 30 May 2020 13:47:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9DF56208E4
	for <linux-kernel@archiver.kernel.org>; Sat, 30 May 2020 13:47:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="FsG5XXnE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728998AbgE3NrY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 30 May 2020 09:47:24 -0400
Received: from mout.gmx.net ([212.227.17.21]:58187 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727851AbgE3NrX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 May 2020 09:47:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1590846440;
        bh=WcYL29cW5/+6PEQzW2ju1mcQX7ep+clRWXF33cw8FPo=;
        h=X-UI-Sender-Class:Subject:From:To:References:Date:In-Reply-To;
        b=FsG5XXnETLgqWPEVQwhMmTdIvQMul1TI7bVhbf+EzrpvtMYH5fYlcAbBH2ccxudCc
         uY2qFk/7OZxvvXCls68amsNvGGpyJINOb510U9OsnlmPl6GFgFLexrtWfyWTBXw9bN
         Dd/To/xrptEfr3TOyKbXAvqJTCM+9A+ld7Z0Mp80=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.178.23] ([77.0.170.188]) by mail.gmx.com (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MryXN-1jBjDh03NN-00o12m for
 <linux-kernel@vger.kernel.org>; Sat, 30 May 2020 15:47:20 +0200
Subject: Re: fatal: unable to access
 'https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/': SSL
 certificate problem: certificate has expired
From:   =?UTF-8?Q?Toralf_F=c3=b6rster?= <toralf.foerster@gmx.de>
To:     Linux Kernel <linux-kernel@vger.kernel.org>
References: <7d5a91f3-e5bd-8410-487d-5cbcd23b174b@gmx.de>
Autocrypt: addr=toralf.foerster@gmx.de; prefer-encrypt=mutual; keydata=
 mQSuBFKhflgRDADrUSTZ9WJm+pL686syYr9SrBnaqul7zWKSq8XypEq0RNds0nEtAyON96pD
 xuMj26LNztqsEA0sB69PQq4yHno0TxA5+Fe3ulrDxAGBftSPgo/rpVKB//d6B8J8heyBlbiV
 y1TpPrOh3BEWzfqw6MyRwzxnRq6LlrRpiCRa/qAuxJXZ9HTEOVcLbeA6EdvLEBscz5Ksj/eH
 9Q3U97jr26sjFROwJ8YVUg+JKzmjQfvGmVOChmZqDb8WZJIE7yV6lJaPmuO4zXJxPyB3Ip6J
 iXor1vyBZYeTcf1eiMYAkaW0xRMYslZzV5RpUnwDIIXs4vLKt9W9/vzFS0Aevp8ysLEXnjjm
 e88iTtN5/wgVoRugh7hG8maZCdy3ArZ8SfjxSDNVsSdeisYQ3Tb4jRMlOr6KGwTUgQT2exyC
 2noq9DcBX0itNlX2MaLL/pPdrgUVz+Oui3Q4mCNC8EprhPz+Pj2Jw0TwAauZqlb1IdxfG5fD
 tFmV8VvG3BAE2zeGTS8sJycBAI+waDPhP5OptN8EyPGoLc6IwzHb9FsDa5qpwLpRiRcjDADb
 oBfXDt8vmH6Dg0oUYpqYyiXx7PmS/1z2WNLV+/+onAWV28tmFXd1YzYXlt1+koX57k7kMQbR
 rggc0C5erweKl/frKgCbBcLw+XjMuYk3KbMqb/wgwy74+V4Fd59k0ig7TrAfKnUFu1w40LHh
 RoSFKeNso114zi/oia8W3Rtr3H2u177A8PC/A5N34PHjGzQz11dUiJfFvQAi0tXO+WZkNj3V
 DSSSVYZdffGMGC+pu4YOypz6a+GjfFff3ruV5XGzF3ws2CiPPXWN7CDQK54ZEh2dDsAeskRu
 kE/olD2g5vVLtS8fpsM2rYkuDjiLHA6nBYtNECWwDB0ChH+Q6cIJNfp9puDxhWpUEpcLxKc+
 pD4meP1EPd6qNvIdbMLTlPZ190uhXYwWtO8JTCw5pLkpvRjYODCyCgk0ZQyTgrTUKOi/qaBn
 ChV2x7Wk5Uv5Kf9DRf1v5YzonO8GHbFfVInJmA7vxCN3a4D9pXPCSFjNEb6fjVhqqNxN8XZE
 GfpKPBMMAIKNhcutwFR7VMqtB0YnhwWBij0Nrmv22+yXzPGsGoQ0QzJ/FfXBZmgorA3V0liL
 9MGbGMwOovMAc56Zh9WfqRM8gvsItEZK8e0voSiG3P/9OitaSe8bCZ3ZjDSWm5zEC2ZOc1Pw
 VO1pOVgrTGY0bZ+xaI9Dx1WdiSCm1eL4BPcJbaXSNjRza2KFokKj+zpSmG5E36Kdn13VJxhV
 lWySzJ0x6s4eGVu8hDT4pkNpQUJXjzjSSGBy5SIwX+fNkDiXEuLLj2wlV23oUfCrMdTIyXu9
 Adn9ECc+vciNsCuSrYH4ut7gX0Rfh89OJj7bKLmSeJq2UdlU3IYmaBHqTmeXg84tYB2gLXaI
 MrEpMzvGxuxPpATNLhgBKf70QeJr8Wo8E0lMufX7ShKbBZyeMdFY5L3HBt0I7e4ev+FoLMzc
 FA9RuY9q5miLe9GJb7dyb/R89JNWNSG4tUCYcwxSkijaprBOsoMKK4Yfsz9RuNfYCn1HNykW
 1aC2Luct4lcLPtg44LQ1VG9yYWxmIEbDtnJzdGVyIChteSAybmQga2V5KSA8dG9yYWxmLmZv
 ZXJzdGVyQGdteC5kZT6IgQQTEQgAKQUCUqF+WAIbIwUJEswDAAcLCQgHAwIBBhUIAgkKCwQW
 AgMBAh4BAheAAAoJEMTqzd4AdulO06EBAIBfWzAIRkMwpCEhY4ZHexa4Ge8C/ql/sBiW8+na
 FxbZAP9z0OgF2zcorcfdttWw0aolhmUBlOf14FWXYDEkHKrmlbkEDQRSoX5YEBAA2tKn0qf0
 kVKRPxCs8AledIwNuVcTplm9MQ+KOZBomOQz8PKru8WXXstQ6RA43zg2Q2WU//ly1sG9WwJN
 Mzbo5d+8+KqgBD0zKKM+sfTLi1zIH3QmeplEHzyv2gN6fe8CuIhCsVhTNTFgaBTXm/aEUvTI
 zn7DIhatKmtGYjSmIwRKP8KuUDF/vQ1UQUvKVJX3/Z0bBXFY8VF/2qYXZRdj+Hm8mhRtmopQ
 oTHTWd+vaT7WqTnvHqKzTPIm++GxjoWjchhtFTfYZDkkF1ETc18YXXT1aipZCI3BvZRCP4HT
 hiAC5Y0aITZKfHtrjKt13sg7KTw4rpCcNgo67IQmyPBOsu2+ddEUqWDrem/zcFYQ360dzBfY
 tJx2oSspVZ4g8pFrvCccdShx3DyVshZWkwHAsxMUES+Bs2LLgFTcGUlD4Z5O9AyjRR8FTndU
 7Xo9M+sz3jsiccDYYlieSDD0Yx8dJZzAadFRTjBFHBDA7af1IWnGA6JY07ohnH8XzmRNbVFB
 /8E6AmFA6VpYG/SY02LAD9YGFdFRlEnN7xIDsLFbbiyvMY4LbjB91yBdPtaNQokYqA+uVFwO
 inHaLQVOfDo1JDwkXtqaSSUuWJyLkwTzqABNpBszw9jcpdXwwxXJMY6xLT0jiP8TxNU8EbjM
 TeC+CYMHaJoMmArKJ8VmTerMZFsAAwUQAJ3vhEE+6s+wreHpqh/NQPWL6Ua5losTCVxY1snB
 3WXF6y9Qo6lWducVhDGNHjRRRJZihVHdqsXt8ZHz8zPjnusB+Fp6xxO7JUy3SvBWHbbBuheS
 fxxEPaRnWXEygI2JchSOKSJ8Dfeeu4H1bySt15uo4ryAJnZ+jPntwhncClxUJUYVMCOdk1PG
 j0FvWeCZFcQ+bapiZYNtju6BEs9OI73g9tiiioV1VTyuupnE+C/KTCpeI5wAN9s6PJ9LfYcl
 jOiTn+037ybQZROv8hVJ53jZafyvYJ/qTUnfDhkClv3SqskDtJGJ84BPKK5h3/U3y06lWFoi
 wrE22plnEUQDIjKWBHutns0qTF+HtdGpGo79xAlIqMXPafJhLS4zukeCvFDPW2PV3A3RKU7C
 /CbgGj/KsF6iPQXYkfF/0oexgP9W9BDSMdAFhbc92YbwNIctBp2Trh2ZEkioeU0ZMJqmqD3Z
 De/N0S87CA34PYmVuTRt/HFSx9KA4bAWJjTuq2jwJNcQVXTrbUhy2Et9rhzBylFrA3nuZHWf
 4Li6vBHn0bLP/8hos1GANVRMHudJ1x3hN68TXU8gxpjBkZkAUJwt0XThgIA3O8CiwEGs6aam
 oxxAJrASyu6cKI8VznuhPOQ9XdeAAXBg5F0hH/pQ532qH7zL9Z4lZ+DKHIp4AREawXNxiGYE
 GBEIAA8FAlKhflgCGwwFCRLMAwAACgkQxOrN3gB26U7PNwEAg6z1II04TFWGV6m8lR/0ZsDO
 15C9fRjklQTFemdCJugA+PvUpIsYgyqSb3OVodAWn4rnnVxPCHgDsANrWVgTO3w=
Message-ID: <8a425b75-cfc7-17b4-3991-63945a855715@gmx.de>
Date:   Sat, 30 May 2020 15:47:19 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.1
MIME-Version: 1.0
In-Reply-To: <7d5a91f3-e5bd-8410-487d-5cbcd23b174b@gmx.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:M2WS4SjO3uzF0js+yaEELvhULOYoOr2o1prC0D9f0VaVoiij3y0
 +jYzGp2eSSVMafRgNFzWNw8R1KrpMJGhcFlnB9DZmtUuoemzIK9iecs59P8bUsZ9q3VYTkb
 Xm3gshGdW8/K/wsASXlNRqx5RTwSGYqGXZcgis1gH6djL5y+kZCORr8L5D9BxkMr/pAAoZ9
 /mnRlqm4AU/TcwwOxHnMA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:tIzUY0UhoQw=:kdlgiP/6Q4XHKQ8s6N5T6f
 SCctm9kpJjwGa1Eotlq/0rdXQ5n9Lrw4DCt80whyART7gziYq1COnb0cSAzlIM6RnWHMmaC4p
 WTJgArolByGRrGNnGsAFrrRxKDWoXmfHwMAWQ2ieMDaQDBfE6jP4UE/XDNMJCfehTGlgQzy/f
 HT2mk81uEib81lZNbc6QZc1WIaxbUMbHpnIBDb8A78x11C8RHKZG2sw9PczJkeLILN0EliHsi
 NDQOWly13bYqb49zJQVYOryorM+Rs5L+NanOL/l5YeFMZM6WrmrG9Zkhd+Xv5tXlPYQeGklyS
 aRSUkON6jYY0v7xZa/5YTndJZNsDUXUtZ8AH26146YW91zxVdmN92BZM8xLNIfF3zbi+0q8pL
 PdZDU9gX2NcxkDslJRHOrCnOoTw1Okcdp/zNN1M8VB2cxIfMNVY0XlMhzcTCPPkGkpV2saRzp
 U7KYEg41CjSZj3K85JemelcSsGIB4X73irbQnw5sEhNmLc2UdnWqMhi4xQpG+JnPv4XladFNs
 VwiAVNymq6nzTnhoERurKiUbM4xCeMNvqQk4q70/HKa6qdmtar4i3pkylxTen78KI6ZAQ7tgu
 fJ0SRjnKJw25sPOt+Tbl2pH4edcJuCkhvHqKK3EoPpJEBfxnQYYF2awAtqiKPgPEB4UhHBPuo
 RGRC/Hbd3oSDSO0b7XrINXrn6O9uuJIoEs2MxwfWRgX9vwY6xAQMIN3klTwJiP9o58fBQXJ+2
 KrWBEjQRomOTdyVu+PWnbhA9z2XjOyZNunHg4TvTxsZ8ZcVl9lkOKEmVzfigmECx01y03WIYl
 0FbXO0aOxvnK++JTj5Ol4xsp1H7UM8bSoqB8USEwKU15VrTRJS62MvCuPihhTI8bk78xSAUOo
 blzh0emVz6jbKBqFXeDKVXgoggvDdFfsM+aV6hzxVx3fMrRUR5SbrTp/YddsyMpmk5qtkTlrc
 0Mae38igqQpw3+OAgmMhjO5rgkeVHrrN19jtHSjF3wJYExQet74XrH10d+UkLdMOeclZo49MS
 8l2H4No07VqxqWeaF8BVVUs8wnAk2VvDBQR68CxjfC9lyFTvCLjFsMUGDT75jjVaXUOui+voF
 KH6iT1PyTdEb63PWKjO4TCMgrhqhTUrwWvwqK0xIS5YpZXG5o2QY6OXSb0qezTT3upXk/J66i
 QH2heTG8Q1jivPq4u2L1jSSyVDcCeSzNOHve8hTW3FeBT72inpOCewCqqtROYXBvii+k4mDy9
 8t1I98ws3QlJtvzgH
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/30/20 3:07 PM, Toralf F=C3=B6rster wrote:
> :-( :
>
> $ export GIT_TRACE=3D1
>
> $ git pull
> 15:07:08.488836 git.c:439               trace: built-in: git pull
> 15:07:08.504295 run-command.c:663       trace: run_command: git fetch --=
update-head-ok
> 15:07:08.506481 git.c:439               trace: built-in: git fetch --upd=
ate-head-ok
> 15:07:08.516608 run-command.c:663       trace: run_command: GIT_DIR=3D.g=
it git-remote-https origin https://git.kernel.org/pub/scm/linux/kernel/git=
/torvalds/linux.git
> fatal: unable to access 'https://git.kernel.org/pub/scm/linux/kernel/git=
/torvalds/linux.git/': SSL certificate problem: certificate has expired
>
> $ curl https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.gi=
t/
> curl: (60) SSL certificate problem: certificate has expired
> More details here: https://curl.haxx.se/docs/sslcerts.html
>
> curl failed to verify the legitimacy of the server and therefore could n=
ot
> establish a secure connection to it. To learn more about this situation =
and
> how to fix it, please visit the web page mentioned above.
>

Well, the cert is expired: "notAfter=3DMay 30 10:48:38 2020 GMT"


echo | openssl s_client -showcerts -connect  git.kernel.org:443
CONNECTED(00000003)
depth=3D1 C =3D SE, O =3D AddTrust AB, OU =3D AddTrust External TTP Networ=
k, CN =3D AddTrust External CA Root
verify error:num=3D10:certificate has expired
notAfter=3DMay 30 10:48:38 2020 GMT
verify return:0
depth=3D1 C =3D SE, O =3D AddTrust AB, OU =3D AddTrust External TTP Networ=
k, CN =3D AddTrust External CA Root
verify error:num=3D10:certificate has expired
notAfter=3DMay 30 10:48:38 2020 GMT
verify return:0
depth=3D3 C =3D SE, O =3D AddTrust AB, OU =3D AddTrust External TTP Networ=
k, CN =3D AddTrust External CA Root
verify error:num=3D10:certificate has expired
notAfter=3DMay 30 10:48:38 2020 GMT
verify return:0
=2D--
Certificate chain
 0 s:/OU=3DDomain Control Validated/OU=3DPositiveSSL Multi-Domain/CN=3Dker=
nel.org
   i:/C=3DFR/ST=3DParis/L=3DParis/O=3DGandi/CN=3DGandi Standard SSL CA 2
=2D----BEGIN CERTIFICATE-----
MIIGszCCBZugAwIBAgIQRF7gFMlJ3UO909a39zv1mzANBgkqhkiG9w0BAQsFADBf
MQswCQYDVQQGEwJGUjEOMAwGA1UECBMFUGFyaXMxDjAMBgNVBAcTBVBhcmlzMQ4w
DAYDVQQKEwVHYW5kaTEgMB4GA1UEAxMXR2FuZGkgU3RhbmRhcmQgU1NMIENBIDIw
HhcNMTkwOTI3MDAwMDAwWhcNMjAwOTI3MjM1OTU5WjBbMSEwHwYDVQQLExhEb21h
aW4gQ29udHJvbCBWYWxpZGF0ZWQxITAfBgNVBAsTGFBvc2l0aXZlU1NMIE11bHRp
LURvbWFpbjETMBEGA1UEAxMKa2VybmVsLm9yZzCCAaIwDQYJKoZIhvcNAQEBBQAD
ggGPADCCAYoCggGBAOD0/Tk0EeH6/ahZQAiBtoMMY8Bxmql2kxJ+smBIP9Yq+MtJ
utc/CeUbnTTnpLDf1nTjqJ6AGyCE+pzw8sPSXKJrY6he1jjCafjsx193KMvqCUty
SZgDdsV7AKr4KjbbQ9CE3tTR1cBKYcCvro4elAXcLbG53qWe/UXwcIPmvwj8n2WW
irMHTr4b+x1Pr7B2Vhc2IHFdnzb43krTXiXuuWCo84281hxO7EIlD3Enjm7rICpU
coldqOaNS3LRkeiR8RrbQfyiqI8XncSykjzVbOZVSVRCvLzRL0MsBKU1F/WMoBYc
ahV92wnYnpGD1s7Wi1eP8ne5+5SPqwS43G4AXxH0hdU7gkHS4i0n7nGmmfRIxD+I
57dvXdnxgSyT21IHp+lMFashblRg8+ZZD5Oy1ouTqBe604FXsjryeQqRUFePTPRB
vYxlg31qne/UUPpo1GcDAjsTv6YSUyUjXoINBQsvpDUgHYkOkHXEyMVRynpBsbJA
p0elmqf4aMr89tn72QIDAQABo4IC7TCCAukwHwYDVR0jBBgwFoAUs5Cn2MmvTs1h
PJ98rV1/Qf1pMOowHQYDVR0OBBYEFLr+wGAi2JEEPCMYIvyjFmMlmLK/MA4GA1Ud
DwEB/wQEAwIFoDAMBgNVHRMBAf8EAjAAMB0GA1UdJQQWMBQGCCsGAQUFBwMBBggr
BgEFBQcDAjBLBgNVHSAERDBCMDYGCysGAQQBsjEBAgIaMCcwJQYIKwYBBQUHAgEW
GWh0dHBzOi8vY3BzLnVzZXJ0cnVzdC5jb20wCAYGZ4EMAQIBMEEGA1UdHwQ6MDgw
NqA0oDKGMGh0dHA6Ly9jcmwudXNlcnRydXN0LmNvbS9HYW5kaVN0YW5kYXJkU1NM
Q0EyLmNybDBzBggrBgEFBQcBAQRnMGUwPAYIKwYBBQUHMAKGMGh0dHA6Ly9jcnQu
dXNlcnRydXN0LmNvbS9HYW5kaVN0YW5kYXJkU1NMQ0EyLmNydDAlBggrBgEFBQcw
AYYZaHR0cDovL29jc3AudXNlcnRydXN0LmNvbTBdBgNVHREEVjBUggprZXJuZWwu
b3JnghJhcmNoaXZlLmtlcm5lbC5vcmeCDmdpdC5rZXJuZWwub3JnghJtaXJyb3Jz
Lmtlcm5lbC5vcmeCDnd3dy5rZXJuZWwub3JnMIIBBAYKKwYBBAHWeQIEAgSB9QSB
8gDwAHYAsh4FzIuizYogTodm+Su5iiUgZ2va+nDnsklTLe+LkF4AAAFtcsuYjgAA
BAMARzBFAiAgbvK3x78RoQXt035wmJqTm/wMFWgfla2ctSyBXLzepAIhAKApjbW3
8p0jlaBkrKQA8eEieenCN5F+PZtm8JSHhAD2AHYAXqdz+d9WwOe1Nkh90EngMnqR
mgyEoRIShBh1loFxRVgAAAFtcsuYsgAABAMARzBFAiEA4JnyL5WAsHHd4WbhqoG6
/C3KFYmZGg04YUFxqAzwbpMCIBjHZMvO/LKSdVcKC45c5FJwc75O/2+7vbkfFAn1
/WV4MA0GCSqGSIb3DQEBCwUAA4IBAQASeh5QNteAKqY+sr7uBTHq56v1MJbbdMO7
QJaCSQd4P2OSQDA83oGfdkj458+d9gMTvBu+pNi1/l0aIz1IMEsuAJNXhN5jLCB/
n1CHaTK5b9Oda96+MejWAiiTNZo1UBLQ5ixNvGp1MHDklELm/supbatSCP65eEpp
E7OI5lLxCLrvsiwUaSKIIO2tEIgwiMkwopdMgwJa7RqljUP7YlYKnAxizOi+yTrA
nXA0OqLtrl5pwnN3Uj/F91X6c6tOvHWkNZ1qPad6r7ZHCP8mq3RFiMeSixiJ6LR2
gtFRKmvMIUIESh60F91+2AeUfCa/tBfOM+PDpsNNaZ+iHHaicAIw
=2D----END CERTIFICATE-----
 1 s:/C=3DFR/ST=3DParis/L=3DParis/O=3DGandi/CN=3DGandi Standard SSL CA 2
   i:/C=3DUS/ST=3DNew Jersey/L=3DJersey City/O=3DThe USERTRUST Network/CN=
=3DUSERTrust RSA Certification Authority
=2D----BEGIN CERTIFICATE-----
MIIF6TCCA9GgAwIBAgIQBeTcO5Q4qzuFl8umoZhQ4zANBgkqhkiG9w0BAQwFADCB
iDELMAkGA1UEBhMCVVMxEzARBgNVBAgTCk5ldyBKZXJzZXkxFDASBgNVBAcTC0pl
cnNleSBDaXR5MR4wHAYDVQQKExVUaGUgVVNFUlRSVVNUIE5ldHdvcmsxLjAsBgNV
BAMTJVVTRVJUcnVzdCBSU0EgQ2VydGlmaWNhdGlvbiBBdXRob3JpdHkwHhcNMTQw
OTEyMDAwMDAwWhcNMjQwOTExMjM1OTU5WjBfMQswCQYDVQQGEwJGUjEOMAwGA1UE
CBMFUGFyaXMxDjAMBgNVBAcTBVBhcmlzMQ4wDAYDVQQKEwVHYW5kaTEgMB4GA1UE
AxMXR2FuZGkgU3RhbmRhcmQgU1NMIENBIDIwggEiMA0GCSqGSIb3DQEBAQUAA4IB
DwAwggEKAoIBAQCUBC2meZV0/9UAPPWu2JSxKXzAjwsLibmCg5duNyj1ohrP0pIL
m6jTh5RzhBCf3DXLwi2SrCG5yzv8QMHBgyHwv/j2nPqcghDA0I5O5Q1MsJFckLSk
QFEW2uSEEi0FXKEfFxkkUap66uEHG4aNAXLy59SDIzme4OFMH2sio7QQZrDtgpbX
bmq08j+1QvzdirWrui0dOnWbMdw+naxb00ENbLAb9Tr1eeohovj0M1JLJC0epJmx
bUi8uBL+cnB89/sCdfSN3tbawKAyGlLfOGsuRTg/PwSWAP2h9KK71RfWJ3wbWFmV
XooS/ZyrgT5SKEhRhWvzkbKGPym1bgNi7tYFAgMBAAGjggF1MIIBcTAfBgNVHSME
GDAWgBRTeb9aqitKz1SA4dibwJ3ysgNmyzAdBgNVHQ4EFgQUs5Cn2MmvTs1hPJ98
rV1/Qf1pMOowDgYDVR0PAQH/BAQDAgGGMBIGA1UdEwEB/wQIMAYBAf8CAQAwHQYD
VR0lBBYwFAYIKwYBBQUHAwEGCCsGAQUFBwMCMCIGA1UdIAQbMBkwDQYLKwYBBAGy
MQECAhowCAYGZ4EMAQIBMFAGA1UdHwRJMEcwRaBDoEGGP2h0dHA6Ly9jcmwudXNl
cnRydXN0LmNvbS9VU0VSVHJ1c3RSU0FDZXJ0aWZpY2F0aW9uQXV0aG9yaXR5LmNy
bDB2BggrBgEFBQcBAQRqMGgwPwYIKwYBBQUHMAKGM2h0dHA6Ly9jcnQudXNlcnRy
dXN0LmNvbS9VU0VSVHJ1c3RSU0FBZGRUcnVzdENBLmNydDAlBggrBgEFBQcwAYYZ
aHR0cDovL29jc3AudXNlcnRydXN0LmNvbTANBgkqhkiG9w0BAQwFAAOCAgEAWGf9
crJq13xhlhl+2UNG0SZ9yFP6ZrBrLafTqlb3OojQO3LJUP33WbKqaPWMcwO7lWUX
zi8c3ZgTopHJ7qFAbjyY1lzzsiI8Le4bpOHeICQW8owRc5E69vrOJAKHypPstLbI
FhfFcvwnQPYT/pOmnVHvPCvYd1ebjGU6NSU2t7WKY28HJ5OxYI2A25bUeo8tqxyI
yW5+1mUfr13KFj8oRtygNeX56eXVlogMT8a3d2dIhCe2H7Bo26y/d7CQuKLJHDJd
ArolQ4FCR7vY4Y8MDEZf7kYzawMUgtN+zY+vkNaOJH1AQrRqahfGlZfh8jjNp+20
J0CT33KpuMZmYzc4ZCIwojvxuch7yPspOqsactIGEk72gtQjbz7Dk+XYtsDe3CMW
1hMwt6CaDixVBgBwAc/qOR2A24j3pSC4W/0xJmmPLQphgzpHphNULB7j7UTKvGof
KA5R2d4On3XNDgOVyvnFqSot/kGkoUeuDcL5OWYzSlvhhChZbH2UF3bkRYKtcCD9
0m9jqNf6oDP6N8v3smWe2lBvP+Sn845dWDKXcCMu5/3EFZucJ48y7RetWIExKREa
m9T8bJUox04FB6b9HbwZ4ui3uRGKLXASUoWNjDNKD/yZkuBjcNqllEdjB+dYxzFf
BT02Vf6Dsuimrdfp5gJ0iHRc2jTbkNJtUQoj1iM=3D
=2D----END CERTIFICATE-----
 2 s:/C=3DUS/ST=3DNew Jersey/L=3DJersey City/O=3DThe USERTRUST Network/CN=
=3DUSERTrust RSA Certification Authority
   i:/C=3DSE/O=3DAddTrust AB/OU=3DAddTrust External TTP Network/CN=3DAddTr=
ust External CA Root
=2D----BEGIN CERTIFICATE-----
MIIFdzCCBF+gAwIBAgIQE+oocFv07O0MNmMJgGFDNjANBgkqhkiG9w0BAQwFADBv
MQswCQYDVQQGEwJTRTEUMBIGA1UEChMLQWRkVHJ1c3QgQUIxJjAkBgNVBAsTHUFk
ZFRydXN0IEV4dGVybmFsIFRUUCBOZXR3b3JrMSIwIAYDVQQDExlBZGRUcnVzdCBF
eHRlcm5hbCBDQSBSb290MB4XDTAwMDUzMDEwNDgzOFoXDTIwMDUzMDEwNDgzOFow
gYgxCzAJBgNVBAYTAlVTMRMwEQYDVQQIEwpOZXcgSmVyc2V5MRQwEgYDVQQHEwtK
ZXJzZXkgQ2l0eTEeMBwGA1UEChMVVGhlIFVTRVJUUlVTVCBOZXR3b3JrMS4wLAYD
VQQDEyVVU0VSVHJ1c3QgUlNBIENlcnRpZmljYXRpb24gQXV0aG9yaXR5MIICIjAN
BgkqhkiG9w0BAQEFAAOCAg8AMIICCgKCAgEAgBJlFzYOw9sIs9CsVw127c0n00yt
UINh4qogTQktZAnczomfzD2p7PbPwdzx07HWezcoEStH2jnGvDoZtF+mvX2do2NC
tnbyqTsrkfjib9DsFiCQCT7i6HTJGLSR1GJk23+jBvGIGGqQIjy8/hPwhxR79uQf
jtTkUcYRZ0YIUcuGFFQ/vDP+fmyc/xadGL1RjjWmp2bIcmfbIWax1Jt4A8BQOujM
8Ny8nkz+rwWWNR9XWrf/zvk9tyy29lTdyOcSOk2uTIq3XJq0tyA9yn8iNK5+O2hm
AUTnAU5GU5szYPeUvlM3kHND8zLDU+/bqv50TmnHa4xgk97Exwzf4TKuzJM7UXiV
Z4vuPVb+DNBpDxsP8yUmazNt925H+nND5X4OpWaxKXwyhGNVicQNwZNUMBkTrNN9
N6frXTpsNVzbQdcS2qlJC9/YgIoJk2KOtWbPJYjNhLixP6Q5D9kCnusSTJV882sF
qV4Wg8y4Z+LoE53MW4LTTLPtW//e5XOsIzstAL81VXQJSdhJWBp/kjbmUZIO8yZ9
HE0XvMnsQybQv0FfQKlERPSZ51eHnlAfV1SoPv10Yy+xUGUJ5lhCLkMaTLTwJUdZ
+gQek9QmRkpQgbLevni3/GcV4clXhB4PY9bpYrrWX1Uu6lzGKAgEJTm4Diup8kyX
HAc/DVL17e8vgg8CAwEAAaOB9DCB8TAfBgNVHSMEGDAWgBStvZh6NLQm9/rEJlTv
A73gJMtUGjAdBgNVHQ4EFgQUU3m/WqorSs9UgOHYm8Cd8rIDZsswDgYDVR0PAQH/
BAQDAgGGMA8GA1UdEwEB/wQFMAMBAf8wEQYDVR0gBAowCDAGBgRVHSAAMEQGA1Ud
HwQ9MDswOaA3oDWGM2h0dHA6Ly9jcmwudXNlcnRydXN0LmNvbS9BZGRUcnVzdEV4
dGVybmFsQ0FSb290LmNybDA1BggrBgEFBQcBAQQpMCcwJQYIKwYBBQUHMAGGGWh0
dHA6Ly9vY3NwLnVzZXJ0cnVzdC5jb20wDQYJKoZIhvcNAQEMBQADggEBAJNl9jeD
lQ9ew4IcH9Z35zyKwKoJ8OkLJvHgwmp1ocd5yblSYMgpEg7wrQPWCcR23+WmgZWn
RtqCV6mVksW2jwMibDN3wXsyF24HzloUQToFJBv2FAY7qCUkDrvMKnXduXBBP3zQ
YzYhBx9G/2CkkeFnvN4ffhkUyWNnkepnB2u0j4vAbkN9w6GAbLIevFOFfdyQoaS8
Le9Gclc1Bb+7RrtubTeZtv8jkpHGbkD4jylW6l/VXxRTrPBPYer3IsynVgviuDQf
Jtl7GQVoP7o81DgGotPmjw7jtHFtQELFhLRAlSv0ZaBIefYdgWOWnU914Ph85I6p
0fKtirOMxyHNwu8=3D
=2D----END CERTIFICATE-----
=2D--
Server certificate
subject=3D/OU=3DDomain Control Validated/OU=3DPositiveSSL Multi-Domain/CN=
=3Dkernel.org
issuer=3D/C=3DFR/ST=3DParis/L=3DParis/O=3DGandi/CN=3DGandi Standard SSL CA=
 2
=2D--
No client certificate CA names sent
Server Temp Key: ECDH, P-256, 256 bits
=2D--
SSL handshake has read 5443 bytes and written 318 bytes
=2D--
New, TLSv1/SSLv3, Cipher is ECDHE-RSA-AES128-GCM-SHA256
Server public key is 3072 bit
Secure Renegotiation IS supported
Compression: NONE
Expansion: NONE
No ALPN negotiated
SSL-Session:
    Protocol  : TLSv1.2
    Cipher    : ECDHE-RSA-AES128-GCM-SHA256
    Session-ID: EAF168D041EF77E19DA9CBAEB78F7827A2A656156EADFDE5C223B84C93=
6821E6
    Session-ID-ctx:
    Master-Key: EA2760F0EA8490E8A970750E6C2467FB49EB34DCFBD27BA5DFA9D8C1DE=
310C07E542CE7B9D6D780F7918B2403437B695
    TLS session ticket lifetime hint: 300 (seconds)
    TLS session ticket:
    0000 - d6 85 e6 6a b2 04 46 c6-33 8a 22 e2 e1 cd f1 66   ...j..F.3."..=
..f
    0010 - 90 c3 19 7a 9d 0f 88 5c-06 bb a0 4d ae 5e 6b e8   ...z...\...M.=
^k.
    0020 - 38 c8 0a 4e 69 96 ad f6-b3 68 bc d8 69 68 25 96   8..Ni....h..i=
h%.
    0030 - bb cd a1 d4 df fa 19 1e-9c 9d 7d d6 34 4b 25 9a   ..........}.4=
K%.
    0040 - 3d 4e 59 9b eb 86 36 42-83 4c 29 f7 06 36 56 02   =3DNY...6B.L)=
..6V.
    0050 - 64 3e 2c bd 49 82 5c 20-4e f4 80 a4 ec 7c 24 0e   d>,.I.\ N....=
|$.
    0060 - 9c 14 3d 47 75 a4 e9 76-44 73 7f 32 6a 80 3a 98   ..=3DGu..vDs.=
2j.:.
    0070 - 2d 18 ef db e8 e1 37 91-e1 28 c3 97 06 33 a0 2e   -.....7..(...=
3..
    0080 - 79 94 c6 9a 4c a6 12 ef-df c5 3d 03 d0 1d 05 c3   y...L.....=3D=
.....
    0090 - 76 32 2e 03 44 24 92 69-f7 0b 01 22 de 34 5b 20   v2..D$.i...".=
4[
    00a0 - 41 a7 6c 7c 56 f8 c7 38-dc 1d 9e ec 45 8b b4 77   A.l|V..8....E=
..w

    Start Time: 1590846354
    Timeout   : 7200 (sec)
    Verify return code: 10 (certificate has expired)
=2D--
DONE
tfoerste@t44 ~/devel/linux $ echo | openssl s_client -showcerts -connect  =
git.kernel.org:443


=2D-
Toralf
