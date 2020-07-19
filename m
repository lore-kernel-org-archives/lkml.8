Return-Path: <SRS0=EKp2=A6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=BAYES_40,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	SUBJ_ALL_CAPS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C05FFC433E0
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Jul 2020 23:38:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A581C208B3
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Jul 2020 23:38:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726890AbgGSXi6 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 19 Jul 2020 19:38:58 -0400
Received: from mail1.bemta25.messagelabs.com ([195.245.230.69]:49115 "EHLO
        mail1.bemta25.messagelabs.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726381AbgGSXi6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Jul 2020 19:38:58 -0400
Received: from [100.112.199.31] (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256 bits))
        by server-5.bemta.az-b.eu-west-1.aws.symcld.net id 31/44-04571-E89D41F5; Sun, 19 Jul 2020 23:38:54 +0000
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrGIsWRWlGSWpSXmKPExsWi9LMqRrf3pki
  8wfMnphaXd81hc2D0+LxJLoAxijUzLym/IoE1Y/2J74wF9xkrdlzvYWxg3MLYxcjFISQwh0ni
  yIUj7BDOfkaJy79a2LoYOTmYBfQkbkydAmbzCghKnJz5hAUiri2xbOFr5i5GDiBbTeJrVwlIW
  FhAUmJ53xMmEFtEQEni+7VuRhCbTUBGYsato6wgNouAqsSVrZuYQFqFBJQljr+Ig5juKnFq7l
  dmEFsIqPzW9YVMExh5ZyE5YhaSI2YhOWIWwhELGFlWMVokFWWmZ5TkJmbm6BoaGOgaGhrpGlq
  a6RoZGuslVukm6aWW6panFpfoGuollhfrFVfmJuek6OWllmxiBAZiSsGRqzsYu9980DvEKMnB
  pCTKu2y5SLwQX1J+SmVGYnFGfFFpTmrxIUYZDg4lCd6U60A5waLU9NSKtMwcYFTApCU4eJREe
  N/dAErzFhck5hZnpkOkTjF6c0x4OXcRM8eDVYuB5Mf9IPLRqiVA8vcLEHnuJZAUYkkvSqyUEu
  eNBxkhADIiozQPbgEsui8xykoJ8zIyMDAI8RSkFuVmlqDKv2IU52BUEuY1BaYKIZ7MvBK4O14
  BncgEdGLLC0GQE0sSEVJSDUzeDda1Rgp6OStfhzb2bT6gPsGTZfoRVZW8vr3Pbh65JBWonXD7
  //z9F+Q1MrvPHH/u8aGwe92p1Y+b1m9cdrUs/+WhjEtHre07vis8NRCvd/LTqU4qS34hsXzn0
  sz2s+r7m2fWnjy+zS3334+i5Ol+XJrcTLeXB+UsmNChkZhZf70y+1/08Zuas8U2fNKQmDF72U
  T/CTMmV8oE+6f7TrvMFSqlKrI4YM+MM/qbn5hPuL5xQ7Muy8s95gs+Smy+vnPVuiMTDzyRma3
  2qrPzjMSiOSc4Tv59tejdWjFTbsfk9g3s/7SET6697v7bo1bbdW2MdcjHPcbcl6VMk7a1/Vd1
  ESmyc34r/UPFNWWTVMxTJZbijERDLeai4kQA4cwUEmkDAAA=
X-Env-Sender: info@axitech.ru
X-Msg-Ref: server-7.tower-283.messagelabs.com!1595201933!290393!2
X-Originating-IP: [34.249.122.92]
X-SYMC-ESS-Client-Auth: outbound-route-from=fail
X-StarScan-Received: 
X-StarScan-Version: 9.50.2; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 1755 invoked from network); 19 Jul 2020 23:38:53 -0000
Received: from mail.vibrantmedia.com (HELO mbx04.vibrant.corp) (34.249.122.92)
  by server-7.tower-283.messagelabs.com with ECDHE-RSA-AES256-SHA384 encrypted SMTP; 19 Jul 2020 23:38:53 -0000
Received: from mbx04.vibrant.corp (2a05:d018:dc8:a8fe:cc13:4a99:59d9:2e4c) by
 mbx04.vibrant.corp (2a05:d018:dc8:a8fe:cc13:4a99:59d9:2e4c) with Microsoft
 SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id 15.1.669.32; Sun, 19
 Jul 2020 23:38:48 +0000
Received: from srvdc01.cpsantisimo.pe (190.102.153.206) by mbx04.vibrant.corp
 (10.1.129.21) with Microsoft SMTP Server id 15.1.669.32 via Frontend
 Transport; Sun, 19 Jul 2020 23:38:48 +0000
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Description: Mail message body
Subject: FOR YOUR PERUSAL
To:     <linux-kernel@vger.kernel.org>
From:   Alex <info@axitech.ru>
Date:   Sun, 19 Jul 2020 18:37:46 -0500
Reply-To: <alex@zephyrelectric.com>
Message-ID: <1ccacf71-7544-4677-b6f5-fba2f3e8eba4@mbx04.vibrant.corp>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hence you did not respond to my prior email with regards to you sharing same name with my late client, I have decided to email you again; but further detail will be communicated to you upon my receipt of your response.
