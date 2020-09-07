Return-Path: <SRS0=/EmK=CQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCA89C43461
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 01:48:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 971D320708
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 01:48:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="hHVVBsL/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726287AbgIGBsc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 6 Sep 2020 21:48:32 -0400
Received: from mailout1.samsung.com ([203.254.224.24]:59360 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725773AbgIGBs2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Sep 2020 21:48:28 -0400
Received: from epcas2p4.samsung.com (unknown [182.195.41.56])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20200907014822epoutp01acaa1533e22d19b06fdfa11ea896ca9a~yXTWRx2Cd1036210362epoutp01J
        for <linux-kernel@vger.kernel.org>; Mon,  7 Sep 2020 01:48:22 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20200907014822epoutp01acaa1533e22d19b06fdfa11ea896ca9a~yXTWRx2Cd1036210362epoutp01J
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1599443302;
        bh=zhRSKR22CkR6gxmuHLjLo1wCkOI8aoqrNBBp3orQ4XY=;
        h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
        b=hHVVBsL/JqOYls9x1VK7AbNBMB3IqjdNPE9UzxetcYEykiT8kFwMECyGWKc4i5qHb
         SrK23hTdrn0lHKoDMCFoS+FlMsijgsC7MvoAN4eFwO+5cXBre+KvtWf+W+JmVNGxC9
         wUne114+8QHRoZS2Yp5KQ77ajlV9c0F7wkzx/i4I=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas2p1.samsung.com (KnoxPortal) with ESMTP id
        20200907014821epcas2p1a340e875134e1bae3868a591671a1d52~yXTVr6dpa0736907369epcas2p1p;
        Mon,  7 Sep 2020 01:48:21 +0000 (GMT)
Received: from epsmges2p3.samsung.com (unknown [182.195.40.183]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 4BlB4y2pK3zMqYmM; Mon,  7 Sep
        2020 01:48:18 +0000 (GMT)
Received: from epcas2p3.samsung.com ( [182.195.41.55]) by
        epsmges2p3.samsung.com (Symantec Messaging Gateway) with SMTP id
        C8.FF.27441.061955F5; Mon,  7 Sep 2020 10:48:17 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas2p4.samsung.com (KnoxPortal) with ESMTPA id
        20200907014816epcas2p44dc5d7b8df2074ce8b085d5b86052ca5~yXTRGZJjx2562125621epcas2p4T;
        Mon,  7 Sep 2020 01:48:16 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20200907014816epsmtrp19701ba7715f88118cd7ae13881718a31~yXTRFkIeX0832008320epsmtrp1c;
        Mon,  7 Sep 2020 01:48:16 +0000 (GMT)
X-AuditID: b6c32a47-fc5ff70000006b31-4b-5f559160b757
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        78.59.08382.061955F5; Mon,  7 Sep 2020 10:48:16 +0900 (KST)
Received: from KORDD001994 (unknown [12.36.185.71]) by epsmtip1.samsung.com
        (KnoxPortal) with ESMTPA id
        20200907014816epsmtip11ff55de9e5da1c0a71674f5d9ce96ffa~yXTQ3LWOc1685716857epsmtip1O;
        Mon,  7 Sep 2020 01:48:16 +0000 (GMT)
From:   =?utf-8?B?6rmA7LC96riw?= <changki.kim@samsung.com>
To:     "'Greg KH'" <gregkh@linuxfoundation.org>
Cc:     <pmladek@suse.com>, <sergey.senozhatsky@gmail.com>,
        <rostedt@goodmis.org>, <john.ogness@linutronix.de>,
        <masahiroy@kernel.org>, <rd.dunlap@gmail.com>, <krzk@kernel.org>,
        <linux-kernel@vger.kernel.org>
In-Reply-To: <20200904103445.GA2693206@kroah.com>
Subject: RE: printk: Add process name information to printk() output.
Date:   Mon, 7 Sep 2020 10:48:16 +0900
Message-ID: <000001d684b8$f48c4290$dda4c7b0$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQMW8ccY1/AbwLmEvIpBmAjIk1luugFhZewlAjg6wOsDEhHwGQJnpmqYppLrVNA=
Content-Language: ko
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrJJsWRmVeSWpSXmKPExsWy7bCmuW7ixNB4gyc7mS2aF69ns9h2ZT6j
        xfnzG9gtLu+aw2bx8MENVov/j7+yWrzY3Mlqsa/jAZPF2s+P2R04PXbOusvu0bLvFrvHplWd
        bB7vzp1j99g/dw27x/otV1k8Pm+SC2CPyrHJSE1MSS1SSM1Lzk/JzEu3VfIOjneONzUzMNQ1
        tLQwV1LIS8xNtVVy8QnQdcvMATpNSaEsMacUKBSQWFyspG9nU5RfWpKqkJFfXGKrlFqQklNg
        aFigV5yYW1yal66XnJ9rZWhgYGQKVJmQk7H/wirmggb5ilsb9zE3MPbKdTFyckgImEisXLGO
        qYuRi0NIYAejxJEv11ggnE+MEpNWvmSFcL4xSrR3XWLsYuQAa5n9XhwivpdRYt/nG4wQzgtG
        iTPnXrCCFLEJWEj8vl8NskJEQEei48wJsKnMAhcYJXq+T2YCSXAKGEqs/HyIEcQWFnCVeH3y
        HTuIzSKgIrF62WEWkDm8ApYSP29WgYR5BQQlTs58wgJiMwtoSyxb+JoZ4gUFiZ9Pl7FC7PKT
        eP5mKytEjYjE7M42ZpC9EgI7OCRe9V5lh2hwkbg8qYsJwhaWeHV8C1RcSuJlfxuUXS/xrX8B
        C0RzD6PE367jbBAJY4lZz9rBIcEsoCmxfpc+JFCUJY7cgrqNT6Lj8F92iDCvREebEISpKtE9
        GapYWuLDDpsJjEqzkPw1C8lfs5DcPwth0wJGllWMYqkFxbnpqcVGBcbIMb2JEZxmtdx3MM54
        +0HvECMTB+MhRgkOZiURXo9zgfFCvCmJlVWpRfnxRaU5qcWHGE2BAT2RWUo0OR+Y6PNK4g1N
        jczMDCxNLUzNjCyUxHmLrS7ECQmkJ5akZqemFqQWwfQxcXBKNTAZhKduc72RU9qQfe3+rmTB
        a3Ux5/yrt9WuVmEMjS96MP1g8d3gnXMuz+KaPuVGVLDa9c8i/L4fN13/7iqfpJi658Ya4UO+
        x4z09p1lNj5yNmjtKw+OUzc2rk77OfPiwVkmm9TT1q3zFzKRWZoyeV2TUOm3xW8vLYuOLRRq
        T2pePH/Rrb//wyeI3DltOVlmz8R7P/Zn30uIT144g+uT4qGnxe/nVLucOvZKqirg/50ZDt//
        iGu0zE1XdteadahwivNey3OXd7Mdm3Jza+bSY/LHlAsPLehalGAXPidKvWv2K2uLp2typW4J
        Houy8DOvMY7ZrrafNXvLrq0Lzx6e/UPy4Pcg86/uvVe/xi84dWxBlIsSS3FGoqEWc1FxIgAV
        h9QPPAQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprCIsWRmVeSWpSXmKPExsWy7bCSnG7CxNB4g3031CyaF69ns9h2ZT6j
        xfnzG9gtLu+aw2bx8MENVov/j7+yWrzY3Mlqsa/jAZPF2s+P2R04PXbOusvu0bLvFrvHplWd
        bB7vzp1j99g/dw27x/otV1k8Pm+SC2CP4rJJSc3JLEst0rdL4Mo4/HkOY8FD4YppT/4yNzAe
        5eti5OCQEDCRmP1evIuRi0NIYDejxKHZ+5i6GDmB4tISx1/NZoewhSXutxxhBbGFBJ4xSnxa
        KwrSyyZgIfH7fjVIWERAR6LjzAkWkDnMArcYJVZ8eMQOUd/GJPFhhyeIzSlgKLHy8yFGEFtY
        wFXi9cl3YDUsAioSq5cdZgGZyStgKfHzZhVImFdAUOLkzCcsIDazgLbE05tP4exlC18zQ5ym
        IPHz6TJWiBv8JJ6/2coKUSMiMbuzjXkCo/AsJKNmIRk1C8moWUhaFjCyrGKUTC0ozk3PLTYs
        MMxLLdcrTswtLs1L10vOz93ECI44Lc0djNtXfdA7xMjEwXiIUYKDWUmE1+NcYLwQb0piZVVq
        UX58UWlOavEhRmkOFiVx3huFC+OEBNITS1KzU1MLUotgskwcnFINTNt36+xhX+ruXRneP/vD
        C8buFbyV9acWnavLEspft4knZV3zlJczbOy3x66+krx06r8zr19t9kkLDV6evdBm58bnyztK
        WnULTCSYnlx+cMI4yS9wc8QplpmaESKLXVN/788tvtU+ydderVG9TNzC1urX5a2CzNKr1A39
        xB/V699oWcRtK1YWWW67b1qD0bRzp2dYLRX1+6s/V6PLuOrqnqzrYdIVl3OdUvmSX1z5P291
        NFPhF871V7uN3GOWZ3O1TAyNE9SdYO4cU/b+Wdd7RX5uFxaORXXtriWLk0X+/lTVvekS51Lw
        8f23hY0FTSoZKrnmVQ1n1M+f/Vr7fXNXRvs+m8+rtD/FnAmOrY1TYinOSDTUYi4qTgQAb7Mu
        SScDAAA=
X-CMS-MailID: 20200907014816epcas2p44dc5d7b8df2074ce8b085d5b86052ca5
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20200904082449epcas2p4420d5df2083325b328a182c79f5c0948
References: <CGME20200904082449epcas2p4420d5df2083325b328a182c79f5c0948@epcas2p4.samsung.com>
        <20200904082438.20707-1-changki.kim@samsung.com>
        <20200904090535.GA2440145@kroah.com>
        <000001d6829e$2226cc60$66746520$@samsung.com>
        <20200904103445.GA2693206@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> On Fri, Sep 04, 2020 at 06:31:13PM +0900,   =C3=A2=20=20=20wrote:=0D=0A>=
=20>=20>=20On=20Fri,=20Sep=2004,=202020=20at=2005:24:38PM=20+0900,=20Changk=
i=20Kim=20wrote:=0D=0A>=20>=20>=20>=20Printk()=20meesages=20are=20the=20mos=
t=20basic=20and=20useful=20debug=20method.=0D=0A>=20>=20>=20>=20However,=20=
additional=20information=20needs=20in=20multi-processor.=0D=0A>=20>=20>=20>=
=20If=20we=20add=20messages=20with=20processor=20id=20and=20process=20name,=
=20we=20can=20find=0D=0A>=20>=20>=20>=20a=20problem=20only=20with=20message=
s=20when=20the=20problem=20occurs=20with=20H/W=20IP=20or=0D=0A>=20CPU.=0D=
=0A>=20>=20>=20>=20This=20is=20very=20useful=20in=20narrowing=20down=20the=
=20scope=20of=20the=20problems.=0D=0A>=20>=20>=20>=0D=0A>=20>=20>=20>=20The=
refore,=20instead=20of=20trying=20to=20help=20buffering,=20let's=20try=20to=
=20help=0D=0A>=20>=20>=20>=20reconstructing=20messages=20by=20saving=20call=
er=20information=20as=20of=20calling=0D=0A>=20>=20>=20>=20log_store()=20and=
=20adding=20it=20as=20=22=5B=24processor_id:=20=24process_name:=0D=0A>=20>=
=20>=20=24thread_id=5D=22=0D=0A>=20>=20>=20>=20upon=20printing=20to=20conso=
les.=0D=0A>=20>=20>=20>=0D=0A>=20>=20>=20>=20Some=20examples=20for=20consol=
e=20output:=0D=0A>=20>=20>=20>=0D=0A>=20>=20>=20>=20=20=20=5B=20=20=20=200.=
059580=5D=20=5B0:=20=20=20=20=20=20swapper/0:=20=20=20=201=5D=20CPU:=20All=
=20CPU(s)=20started=20at=0D=0A>=20>=20EL1i=0D=0A>=20>=20>=20>=20=20=20=5B=
=20=20=20=202.153157=5D=20=5B5:=20=20=20=20=20=20=20=20=20=20=20init:=20=20=
=20=201=5D=20migov:=20complete=20to=20probe=0D=0A>=20>=20migov=0D=0A>=20>=
=20>=20>=20=20=20=5B=20=20=20=207.441317=5D=20=5B4:=20=20=20=20=20=20=20=20=
=20=20=20init:=20=20=20=201=5D=20NET:=20Registered=20protocol=0D=0A>=20>=20=
family=2039=0D=0A>=20>=20>=20>=20=20=20=5B=20=20=2022.793389=5D=20=5B5:=20=
=20kworker/u16:1:=20=20184=5D=20SMP:=20stopping=20secondary=0D=0A>=20CPUs=
=0D=0A>=20>=20>=20>=0D=0A>=20>=20>=20>=20Signed-off-by:=20Changki=20Kim=20<=
changki.kim=40samsung.com>=0D=0A>=20>=20>=20>=20---=0D=0A>=20>=20>=20>=20=
=20kernel/printk/printk.c=20=20=20=20=20=20=20=20=20=20=20=20=7C=2020=20+++=
+++++++++++++++--=0D=0A>=20>=20>=20>=20=20kernel/printk/printk_ringbuffer.h=
=20=7C=20=207=20+++++++=0D=0A>=20>=20>=20>=20=20lib/Kconfig.debug=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=7C=2016=20++++++++++++++++=0D=0A=
>=20>=20>=20>=20=203=20files=20changed,=2041=20insertions(+),=202=20deletio=
ns(-)=0D=0A>=20>=20>=0D=0A>=20>=20>=20Isn't=20the=20CPU=20number=20already=
=20present=20if=20you=20want=20it=20today?=20=20Why=20add=0D=0A>=20>=20>=20=
it=20again?=0D=0A>=20>=20>=0D=0A>=20>=20>=20thanks,=0D=0A>=20>=20>=0D=0A>=
=20>=20>=20greg=20k-h=0D=0A>=20>=0D=0A>=20>=20CPU=20number=20isn't=20presen=
t=20now.=20If=20I=20enabled=20PRINTK_CALLER,=20then=20it=20is=0D=0A>=20>=20=
present=20cpu=20id=20or=20thread=20id.=0D=0A>=20=0D=0A>=20Great,=20that=20s=
hould=20give=20you=20what=20you=20need=20here,=20right?=0D=0A>=20=0D=0A>=20=
>=20The=20config=20isn't=20always=20present=20cpu=20id.=0D=0A>=20=0D=0A>=20=
What=20do=20you=20mean?=0D=0A=0D=0AWhen=20PRINTK_CALLER=20is=20enabled,=20c=
pu=20id=20or=20thread=20id=20are=20present.=20not=20always=20cpu=20id.=0D=
=0A>=20=0D=0A>=20>=20We=20need=20cpu=20id=20each=20each=20message.=0D=0A>=
=20=0D=0A>=20Why=20each=20message?=20=20What=20does=20that=20provide=20you?=
=0D=0A=0D=0AIn=20mobile=20project,=20Sometimes=20we=20can=20meet=20the=20pr=
oblem=20in=20the=20physically=20cpu.=0D=0AIt=20is=20important=20to=20know=
=20cpu=20id=20for=20H/W=20Issue.=0D=0A>=20=0D=0A>=20And=20if=20PRINTK_CALLE=
R=20does=20not=20work=20properly,=20please=20fix=20it.=20=20I=20don't=20see=
=0D=0A>=20how=20it=20would=20not=20work=20any=20different=20from=20your=20p=
atch,=20you=20shouldn't=0D=0A>=20duplicate=20things.=0D=0A=0D=0APRINTK_CALL=
ER=20worked=20well.=0D=0A>=20=0D=0A>=20thanks,=0D=0A>=20=0D=0A>=20greg=20k-=
h=0D=0A=0D=0A
