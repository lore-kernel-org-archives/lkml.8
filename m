Return-Path: <SRS0=1j9/=3N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48C47C2D0CE
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 09:34:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0843A214AF
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 09:34:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579858491;
	bh=EMmJPFj4rGAezsZBCt4bgc4a5LhL727zULtXNIxpHh4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=MDBSFsdfToQbrd21CApErxjb/eByiNNGBtobh5VVzbL9XEjkklONilsYiwcaBDWJw
	 YbIqdvbjr8Vm0jxvqjlNHDuq1ClZs7p0e+JG/vGwSNaidM6muZ6ZI0N9akHiUij+M8
	 Nx2l6O3DqHpFuw8c6ohEdVFa47z2FMwWJzjmDytI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731033AbgAXJeu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jan 2020 04:34:50 -0500
Received: from mail.kernel.org ([198.145.29.99]:33218 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731007AbgAXJer (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jan 2020 04:34:47 -0500
Received: from localhost (unknown [145.15.244.15])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 01038214AF;
        Fri, 24 Jan 2020 09:34:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579858486;
        bh=EMmJPFj4rGAezsZBCt4bgc4a5LhL727zULtXNIxpHh4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=w76LdsHWMogtN6Bl2Mius6M7AHNFP8DeMg0lx3ZJefYPIEhGeVTbFzyYTreLT+R/8
         5xer+F1VyYTj2v4C7CWDZXaLeQslhCNrfIXvV0b0HJ3OS4wSekQ6aaVB0tjsFIX3CA
         5q3s/MoLQ1W84CE75H+Bpbbqg9Tf7+GtN7iICgD4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Alain Volmat <alain.volmat@st.com>,
        Pierre-Yves MORDRET <pierre-yves.mordret@st.com>,
        Wolfram Sang <wsa@the-dreams.de>
Subject: [PATCH 5.4 014/102] i2c: stm32f7: rework slave_id allocation
Date:   Fri, 24 Jan 2020 10:30:15 +0100
Message-Id: <20200124092808.289516237@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200124092806.004582306@linuxfoundation.org>
References: <20200124092806.004582306@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alain Volmat <alain.volmat@st.com>

commit 52d3be711e065a97a57c2f2ffba3098748855bd6 upstream.

The IP can handle two slave addresses. One address can either be
7 bits or 10 bits while the other can only be 7 bits.
In order to ensure that a 10 bits address can always be allocated
(assuming there is only one 7 bits address already allocated),
pick up the 7-bits only address slot in priority when performing a 7-bits
address allocation.

Fixes: 60d609f30de2 ("i2c: i2c-stm32f7: Add slave support")
Signed-off-by: Alain Volmat <alain.volmat@st.com>
Reviewed-by: Pierre-Yves MORDRET <pierre-yves.mordret@st.com>
Signed-off-by: Wolfram Sang <wsa@the-dreams.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/i2c/busses/i2c-stm32f7.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/i2c/busses/i2c-stm32f7.c
+++ b/drivers/i2c/busses/i2c-stm32f7.c
@@ -1267,7 +1267,7 @@ static int stm32f7_i2c_get_free_slave_id
 	 * slave[0] supports 7-bit and 10-bit slave address
 	 * slave[1] supports 7-bit slave address only
 	 */
-	for (i = 0; i < STM32F7_I2C_MAX_SLAVE; i++) {
+	for (i = STM32F7_I2C_MAX_SLAVE - 1; i >= 0; i--) {
 		if (i == 1 && (slave->flags & I2C_CLIENT_PEC))
 			continue;
 		if (!i2c_dev->slave[i]) {


