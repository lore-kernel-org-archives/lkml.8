Return-Path: <SRS0=iqK9=5A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 659F4C4CECE
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Mar 2020 09:28:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E435206B1
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Mar 2020 09:28:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728153AbgCOJ2h (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 15 Mar 2020 05:28:37 -0400
Received: from m17617.mail.qiye.163.com ([59.111.176.17]:4452 "EHLO
        m17617.mail.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726521AbgCOJ2h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Mar 2020 05:28:37 -0400
Received: from ubuntu.localdomain (unknown [58.251.74.226])
        by m17617.mail.qiye.163.com (Hmail) with ESMTPA id 0C3E82613D7;
        Sun, 15 Mar 2020 17:28:29 +0800 (CST)
From:   Wang Wenhu <wenhu.wang@vivo.com>
To:     Jonathan Corbet <corbet@lwn.net>, Vivek Goyal <vgoyal@redhat.com>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Harry Wei <harryxiyou@gmail.com>,
        Alex Shi <alex.shi@linux.alibaba.com>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "Daniel W. S. Almeida" <dwlsalmeida@gmail.com>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Eric Biggers <ebiggers@google.com>,
        Wang Wenhu <wenhu.wang@vivo.com>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        linux-fsdevel@vger.kernel.org
Cc:     kernel@vivo.com
Subject: [PATCH 0/2] doc: zh_CN: facilitate translation for filesystems
Date:   Sun, 15 Mar 2020 02:27:58 -0700
Message-Id: <20200315092810.87008-1-wenhu.wang@vivo.com>
X-Mailer: git-send-email 2.17.1
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgYFAkeWUFZTlVIT0tCQkJNS0hJTEpPQ1lXWShZQU
        hPN1dZLVlBSVdZCQ4XHghZQVk1NCk2OjckKS43PlkG
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6MTo6Pzo5KDg6ODcYLEgOK1Y#
        PjRPCh1VSlVKTkNPSU1PTkpKTUJJVTMWGhIXVQweFRMOVQwaFRw7DRINFFUYFBZFWVdZEgtZQVlO
        Q1VJTkpVTE9VSUlNWVdZCAFZQUlDQ0k3Bg++
X-HM-Tid: 0a70dd85f8929375kuws0c3e82613d7
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series set up the basic facility for the translation work
of the docs residing on filesystems into Chinese, indexing the filesystems
directory and adding one indexed translation into it. The virtiofs.rst
added is not only a translation itself but also an simple example that
future developers would take.

The detailed diff info also shows the basic essential markups of
the toctree and reStructuredText, at least for the most simple occasions.
More translations of filesystems are on their way, and futher,
of more subsystems.

---
Wang Wenhu (2):
  doc: zh_CN: index files in filesystems subdirectory
  doc: zh_CN: add translation for virtiofs

 Documentation/filesystems/index.rst           |  2 +
 Documentation/filesystems/virtiofs.rst        |  2 +
 .../translations/zh_CN/filesystems/index.rst  | 29 +++++++++
 .../zh_CN/filesystems/virtiofs.rst            | 62 +++++++++++++++++++
 Documentation/translations/zh_CN/index.rst    |  1 +
 5 files changed, 96 insertions(+)
 create mode 100644 Documentation/translations/zh_CN/filesystems/index.rst
 create mode 100644 Documentation/translations/zh_CN/filesystems/virtiofs.rst

-- 
2.17.1

