Return-Path: <SRS0=NqQd=7Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: **
X-Spam-Status: No, score=2.3 required=3.0 tests=CHARSET_FARAWAY_HEADER,
	DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 378E6C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 09:36:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 06F9B20656
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 09:36:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="rzq/QC/j"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727002AbgFKJgE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Jun 2020 05:36:04 -0400
Received: from mailout2.samsung.com ([203.254.224.25]:30297 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726907AbgFKJgD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Jun 2020 05:36:03 -0400
Received: from epcas2p2.samsung.com (unknown [182.195.41.54])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20200611093559epoutp022c53d2c989dd387b1f3b3fe324fb5973~Xc6g1EYmt2746827468epoutp02y
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jun 2020 09:35:59 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20200611093559epoutp022c53d2c989dd387b1f3b3fe324fb5973~Xc6g1EYmt2746827468epoutp02y
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1591868159;
        bh=BtLqdwk0y62r0bKzoUyZMTBDKgQAGUEqllosYfEBUus=;
        h=From:To:Cc:Subject:Date:References:From;
        b=rzq/QC/jlAK96V2FoYPOEyCYl9DGuXnx8PsqAUeJ6ZMOzN0/UsBKUBOfOPm0U/NHd
         UabACJuGHBIgV83y79CK2qN6NRVnxbOHVR13Cs9h4MDNQcWOh/l41qv1aJYTpQ7XIZ
         rVWiIRkB4OCC+vkvWj3u56kN1BXJfkOMXXtwtsb0=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas2p4.samsung.com (KnoxPortal) with ESMTP id
        20200611093558epcas2p432f4a06420aeacb688be7054031f9c78~Xc6gHowQF2615926159epcas2p40;
        Thu, 11 Jun 2020 09:35:58 +0000 (GMT)
Received: from epsmges2p1.samsung.com (unknown [182.195.40.189]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 49jJd70ZlfzMqYkp; Thu, 11 Jun
        2020 09:35:55 +0000 (GMT)
Received: from epcas2p4.samsung.com ( [182.195.41.56]) by
        epsmges2p1.samsung.com (Symantec Messaging Gateway) with SMTP id
        51.42.19322.AFAF1EE5; Thu, 11 Jun 2020 18:35:54 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas2p2.samsung.com (KnoxPortal) with ESMTPA id
        20200611093554epcas2p293e988bd3352b59d7933e2737ed1c3d3~Xc6bz3OMK2069220692epcas2p2j;
        Thu, 11 Jun 2020 09:35:54 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20200611093554epsmtrp292bdabcb3d17bc34fdd409c67dedddd9~Xc6bvsopj3074130741epsmtrp2H;
        Thu, 11 Jun 2020 09:35:54 +0000 (GMT)
X-AuditID: b6c32a45-797ff70000004b7a-64-5ee1fafaa1e5
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        D5.DE.08382.9FAF1EE5; Thu, 11 Jun 2020 18:35:53 +0900 (KST)
Received: from KORCO009652 (unknown [12.36.182.243]) by epsmtip2.samsung.com
        (KnoxPortal) with ESMTPA id
        20200611093553epsmtip25e7c702823559322ad67d6eb752ab2c8~Xc6bb53Fn0097200972epsmtip2w;
        Thu, 11 Jun 2020 09:35:53 +0000 (GMT)
From:   =?ks_c_5601-1987?B?sei/7L+s?= <wooy88.kim@samsung.com>
To:     "'Dave Martin'" <Dave.Martin@arm.com>,
        "'Mark Rutland'" <mark.rutland@arm.com>
Cc:     "'Catalin       Marinas'" <catalin.marinas@arm.com>,
        "'Bhupesh Sharma'" <bhsharma@redhat.com>,
        "'Julien Grall'" <julien.grall@arm.com>,
        "'Vincenzo Frascino'" <vincenzo.frascino@arm.com>,
        "'Will Deacon'" <will@kernel.org>, <yhwan.joo@samsung.com>,
        "'Anisse Astier'" <aastier@freebox.fr>,
        "'Marc Zyngier'" <maz@kernel.org>,
        "'Allison Randal'" <allison@lohutok.net>,
        "'Sanghoon Lee'" <shoon114.lee@samsung.com>,
        <jihun.kim@samsung.com>, "'Kees Cook'" <keescook@chromium.org>,
        "'Suzuki K Poulose'" <suzuki.poulose@arm.com>,
        "'Wooki Min'" <wooki.min@samsung.com>,
        "'Kristina Martsenko'" <kristina.martsenko@arm.com>,
        "'Jeongtae Park'" <jtp.park@samsung.com>,
        "'Thomas Gleixner'" <tglx@linutronix.de>,
        <linux-arm-kernel@lists.infradead.org>,
        "'Steve Capper'" <steve.capper@arm.com>,
        "'Greg Kroah-Hartman'" <gregkh@linuxfoundation.org>,
        <linux-kernel@vger.kernel.org>,
        "'James Morse'" <james.morse@arm.com>,
        "'Sudeep Holla'" <sudeep.holla@arm.com>, <dh.han@samsung.com>
Subject: =?ks_c_5601-1987?B?yLi89jogW1BBVENIXSBhcm02NDogZnBzaW1kOiBBZGRlZA==?=
 =?ks_c_5601-1987?B?IEFQSSB0byBtYW5hZ2UgZnBzaW1kIHN0YXRlIGluc2lkZQ==?=
 =?ks_c_5601-1987?B?IGtlcm5lbA==?=
Date:   Thu, 11 Jun 2020 18:35:54 +0900
Message-ID: <!&!GAAAAAAAAABpCkMESMNhT6Ct/ir2KGyEwoAAABgAAAAAAAAAaQpDBEjDYU+grf4q9ihshOTUIAAAAAAAEAAAAPZb5MAxsPRBiTL0z35GHpdKAAAAUkU6IFtQQVRDSF0gYXJtNjQ6IGZwc2ltZDogQWRkZWQgQVBJIHRvIG1hbmFnZSBmcHNpbWQgc3RhdGUgaW5zaWRlIGtlcm5lbAA=@samsung.com>
MIME-Version: 1.0
Content-Type: multipart/mixed;
        boundary="----=_NextPart_000_0010_01D6401F.23C698F0"
X-Mailer: Microsoft Outlook 16.0
Expiry-Date: Sat, 13 Jun 2020 18:35:52 +0900
X-MS-TNEF-Correlator: 00000000690A430448C3614FA0ADFE2AF6286C84E4D52000
X-Brightmail-Tracker: H4sIAAAAAAAAA2VTe0xTVxzOuff2AabL5eE4a8asHS5TB7adhcMChgQwdxlxLLAsOqUrcAOE
        vmzLdHPLEJShrChOQRAGowKTRxiFIQ+BDRAsOCYPkdeChW4gIgjCJm6QtVxISPbf9/vO9/3O
        78s5Py7ufJvD58ap9LRWJVcI2Y5Ebdtu5PnihSVC1JGNUFFfLo5u3Fkj0PezXSw0X/wNQEl5
        twB6kpKFo2RjJRuNN5dgaKrIwkbtFfcxlFJwCN1NU6LxzhQWMk0OslB/Qy4bFT3oxVB9rpmF
        LI9GcXRpthZDJV11BMoeHQWo2nQFR01rKwQ6MyZF+aNlGLp2x8gK4FPl35UD6lpiL0FVXhgn
        KFPpOTY119PDoVryyjlU9fWvqIVZK4eab77PptJrSgH1zPRa6LYjCr9YWh5NawW0KkodHaeK
        8Re+FyYLlEm9RWJPsS/yEQpUciXtLwwKCfU8GKew5RcKPpUrEmxUqFynE+474KdVJ+hpQaxa
        p/cX0ppohUYs1njp5EpdgirGK0qtfEcsEkmkNuUnitgCQxVLM+d68kzyCicRfO16HjhwIbkf
        Lo5ZsfPAketM1gH41HgDMMUigKeHp3Cm+AtAY+UKe9PSkFm4YWkCcHy6n8MUjwD8PcPKsqvY
        pB+8MlwF7NiVDIe93UtsuwgnRzhwMsPMshcuZAOA/043EnYVQe6C1Z3z6wc8cgHA1b7C9VY8
        0gmas63rIpz8EBqKGwAziACu/FFs03C5LPItuPLrcYY+CJ8vLmAMHnSAVf8cZXAQzGwc2OBd
        4ExnDYfBfPhsrmkj2ylYYDSsx4FkKoBXz7VtGN6GNXldmP0uSL4O20c2xnkJpratchiaB1NT
        nBm1B/zb1M3ebP9wpg9nMAUvGs6uT+9MHoPJP+SyLwJBzpaQOVtCMlgCr5flYwzeCS+nWTgM
        lsKB5dPE/3kfmHGzgigAnFLwMq3RKWNonUQj3vopTGB9h/YE14Fvnzz1agUYF7QCD5t34sey
        e4BPqNQqWujKc3KzRDjzouWffU5r1TJtgoLWtQKp7aEycP72KLVtIVV6mVgq8fYW+UqR1FuC
        hG485c57Ec5kjFxPx9O0htZu+jCuAz8ROzqxX5ZOuvjtym85iXUE73NUN6ZbqWmRbyRL+8Wc
        r2Wy/HBAeGDythJjYLOpvvSQjJ9zFk8Y+qBpdHLx8S9fmq9+/KbFLfgn6e4j5CWRxD/GJ5TV
        0j78PKwyPn3VLfhxZnfPG+9m3dVnupTspSpGThmy3t8bUjSUUQtTx52204JBfcGO30a4N5eC
        rPyMpdjlSINXoPbPCWlvVFCz8tVbJQrHC7cDfcDlieITnsPH3JNCZC11kR2WHSsLDq9EH1c0
        FfNjfg73MQ8mhVcRrh0fHcaWp40twe4nDnSz3ETytKmk+IChsNnYmf7CrrHB9IFh9/o1j64K
        I15a8zBq4MF0qllI6GLl4j24Vif/D91LzB3YBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA2WSfVDLcRzHfX8P26/czs+W62vuPAw5HWMev06H8/jjj/jDw9Fd2uWnnLbW
        Vh7qMG0XtSKVOinKtGUilqtMom2uJFEOZeiWuS6mTC6GIht37vz3vvf79f58Pn98KJyfTgqp
        PfJEVimXxok4gUS1TTRptvebM3LuKRKVtRfh6FLTMIFK3c0k6jdkApRaXAfQh7QCHGn0lRzU
        VW/EUE+Zk4PsV55iKK0kHLXoZKirMY1E5jfPSPTEUsRBZc/bMHSz6D6JnL0OHOW4qzFkbK4l
        0BmHA6Aq82kc3R72Ekj7ciE677iMobNNenKFkKk4VwGYs+o2gqk82UUwZlM6h+lrbeUyd4or
        uEzVxSOMx+3iMv31TznMiRsmwAyYJ24avSMwbBcbt2cfq5yzLCowtrs1C1cMBh3QarxcNTgW
        lAECKEgvgJb8C1gGCKT49C0A7W19hD8QQqu6lOvXAtiltZN+qAfAFvddH8Shw+Dpzuvgtw6i
        N8PShnYfhNN9XKhPz/SNFdAWACs8X3wUQU+HVY39PopHewAcar9A/g549Fh4/4zLNxant8As
        gwX4d0+G3reGEYaiSHoW9D5M8Ntr4ddPHiwb0IX/tAv/afv1AnjUpvvjT4F5OifXrxdDteMt
        +N9fAr92GogSwDWB8axCJYuRqSQKiZzdL1ZJZaokeYw4Ol5mBr4PCZ1ZC2pMH8VWgFHACqaN
        1LuvXX4MhIQ8Xs6Kgnhjg52RfN4u6cFkVhm/U5kUx6qsYAJFiIJ5HQmlkXw6RprI7mVZBav8
        m2JUgFCNHU7aXZu9tXeMfeSc9eXjVwzbcoVzi/tdK7c9/7y4ZuMhwzL1EuZi54OpA3UOKy+6
        XLYl8knNs4ghiXBreV5P2bS7h2f+TAk91c3OH1W8za0Jy7BmbTQcbejVa5MK+KZZEaLw8IbM
        9/HGlEqNLnW5OOdAyCuw1Cb+sjp2c0Gddm1+4/cToyYzHRH5heyjK8m1kpzjrh8tunmzq212
        GWO7uWZKe477EJHorYy6+mHNtxkaQ4KL3mDMbhKEDKpvZGQOXh14+NPYkfVam2rz8AX1rksz
        RNO3C/almjnBruSA3HHRmHZH/vt3eevu6VNEiqFcelJ3Y5QlRdK8aKH+xSrxsIhQxUolobhS
        Jf0FhOr/EpwDAAA=
X-CMS-MailID: 20200611093554epcas2p293e988bd3352b59d7933e2737ed1c3d3
X-Msg-Generator: CA
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20200611093554epcas2p293e988bd3352b59d7933e2737ed1c3d3
References: <CGME20200611093554epcas2p293e988bd3352b59d7933e2737ed1c3d3@epcas2p2.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multipart message in MIME format.

------=_NextPart_000_0010_01D6401F.23C698F0
Content-Type: text/plain; charset="ks_c_5601-1987"
Content-Transfer-Encoding: base64

sei/7L+swMwosKEpICJbUEFUQ0hdIGFybTY0OiBmcHNpbWQ6IEFkZGVkIEFQSSB0byBtYW5hZ2Ug
ZnBzaW1kIHN0YXRlDQppbnNpZGUga2VybmVsIiC43r3Dwfa4piDIuLz2x8+3wbDtIMfVtM+02S4N
Cg==
------=_NextPart_000_0010_01D6401F.23C698F0
Content-Type: application/ms-tnef; name="winmail.dat"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="winmail.dat"

eJ8+IjYJAQaQCAAEAAAAAAABAAEAAQeQBgAIAAAAtQMAAAAAAAC4AAEIgAcAEwAAAElQTS5PdXRs
b29rLlJlY2FsbACCBgEDkAYAoAUAABsAAAADACYAAQAAAAIBMQABAAAAbQEAAFBDREZFQjA5AAEA
AgC+AAAAAAAAADihuxAF5RAaobsIACsqVsIAAG1zcHN0LmRsbAAAAAAATklUQfm/uAEAqgA32W4A
AAAAQwA6AFwAVQBzAGUAcgBzAFwAdwBvAG8AeQA4ADgALgBrAGkAbQBcAEQAbwBjAHUAbQBlAG4A
dABzAFwATwB1AHQAbABvAG8AawAgAAzTfMdcAHcAbwBvAHkAOAA4AC4AawBpAG0AQABzAGEAbQBz
AHUAbgBnAC4AYwBvAG0ALgBwAHMAdAAAABgAAAAAAAAAaQpDBEjDYU+grf4q9ihshMKAAAAYAAAA
AAAAAGkKQwRIw2FPoK3+KvYobITk1CAAAAAAABAAAAD2W+TAMbD0QYky9M9+Rh6XSgAAAFJFOiBb
UEFUQ0hdIGFybTY0OiBmcHNpbWQ6IEFkZGVkIEFQSSB0byBtYW5hZ2UgZnBzaW1kIHN0YXRlIGlu
c2lkZSBrZXJuZWwAAAAAHgBwAAEAAABOAAAAAQXIuLz2OiBbUEFUQ0hdIGFybTY0OiBmcHNpbWQ6
IEFkZGVkIEFQSSB0byBtYW5hZ2UgZnBzaW1kIHN0YXRlIGluc2lkZSBrZXJuZWwAAAALAAEOAQAA
AAMAFA4BAAAAHgAoDgEAAAA3AAAAMDAwMDAwMDUBd29veTg4LmtpbUBzYW1zdW5nLmNvbQF3b295
ODgua2ltQHNhbXN1bmcuY29tAAAeACkOAQAAADcAAAAwMDAwMDAwNQF3b295ODgua2ltQHNhbXN1
bmcuY29tAXdvb3k4OC5raW1Ac2Ftc3VuZy5jb20AAAIBAGgBAAAAEAAAAPZb5MAxsPRBiTL0z35G
HpcDAAFoAQAAAB4AAmgBAAAACQAAAElQTS5Ob3RlAAAAAAsAA2gBAAAAAwAEaAAAAAADAKOACCAG
AAAAAADAAAAAAAAARgAAAAAahQAAAQAAAAsAHw4BAAAAAgH4DwEAAAAQAAAAaQpDBEjDYU+grf4q
9ihshAIB+g8BAAAAEAAAAGkKQwRIw2FPoK3+KvYobIQDAP4PBQAAAAIBCRABAAAAaQEAAGUBAABB
AgAATFpGdTvHkIwDAAoAcmNwZzEyNSIyA0N0ZXgFQmJp/mQEAAMwAQMB9wqAAqQD4wkCAGNoCsBz
ZXQw/iAHEwKAEHMAUARWCFUHsu8SRQ5RAwERRzIGAAbDEkXOMwRGEUkTX2Y0EN4OIOA5IEd1bAdw
AoASU9sI7wn3OxtPDjA1EkIMYM5jAFALCQFkMzYR0Aum4QMwaHRtbAAhGIUMARMgNR9xJ2IAUCdl
OD0h0WYiEQDgImMA0SdjMwFAI2BjKCHRI4FhMQApICJbUEFUQwhIXSAKwG02NDpIIGZwAJBtZCVg
QQpkAQBkEeBQSSB0RG8gA4FhZ2UldSB2cwGQDrAgC4AAkAEAIOJrBJFlbCIhwiJBAQA/IdELMCNg
FlAjYCIBZjbpKQRhNiHBYyJCIkIiwfkqYmM3I1EigQGwKgQkAvMmMSwUZDUh0RiwLGQuUdhkOS4g
JgKxfSE5CrEFCoB9MQAAAAADAA00/T+lDgMADzT9P6UOAgEUNAEAAAAQAAAATklUQfm/uAEAqgA3
2W4AAAIBfwABAAAAMQAAADAwMDAwMDAwNjkwQTQzMDQ0OEMzNjE0RkEwQURGRTJBRjYyODZDODRF
NEQ1MjAwMAAAAAADAAYQwrpgrAMABxBfAAAAAwAQEAAAAAADABEQAQAAAB4ACBABAAAAYAAAALHo
v+y/rMDMKLChKSJQQVRDSEFSTTY0OkZQU0lNRDpBRERFREFQSVRPTUFOQUdFRlBTSU1EU1RBVEVJ
TlNJREVLRVJORUwiuN69w8H2uKbIuLz2x8+3wbDtx9W0z7TZAMBt

------=_NextPart_000_0010_01D6401F.23C698F0--

