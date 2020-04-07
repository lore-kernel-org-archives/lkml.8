Return-Path: <SRS0=z/zp=5X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52D3EC2BA16
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 06:53:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B69620692
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 06:53:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="aN2DVBU4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727512AbgDGGxq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Apr 2020 02:53:46 -0400
Received: from mailout4.samsung.com ([203.254.224.34]:10860 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726448AbgDGGxp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Apr 2020 02:53:45 -0400
Received: from epcas1p1.samsung.com (unknown [182.195.41.45])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20200407065343epoutp041a6b48f2e365895ba7df509911db122f~DdxRXgvlq1862818628epoutp04A
        for <linux-kernel@vger.kernel.org>; Tue,  7 Apr 2020 06:53:43 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20200407065343epoutp041a6b48f2e365895ba7df509911db122f~DdxRXgvlq1862818628epoutp04A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1586242423;
        bh=UPNrIh609ZGpZYtzuBZxbEy0b7DewqD3ARtrX5naw8o=;
        h=From:Subject:To:Cc:Date:References:From;
        b=aN2DVBU40Oo2Z4K613SUAji0KlqHqKeCtxN75XQghNRTCxKl5RMNbPKkc2FjlXaFs
         6VfF017+0QnUp8XWNRaNRYMSvQFKc+Gs180fAi61fPuiZ55t4RJlidfynytU2loEtC
         Nc3/WJxRPSqIzNKl53i3sKBmjE7GtU5ncpKmxebo=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTP id
        20200407065342epcas1p1850b81d4d79a42181466be7717710a72~DdxRLtG-N1071510715epcas1p1k;
        Tue,  7 Apr 2020 06:53:42 +0000 (GMT)
Received: from epsmges1p4.samsung.com (unknown [182.195.40.163]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 48xJ5w6dFszMqYkk; Tue,  7 Apr
        2020 06:53:40 +0000 (GMT)
Received: from epcas1p4.samsung.com ( [182.195.41.48]) by
        epsmges1p4.samsung.com (Symantec Messaging Gateway) with SMTP id
        F8.CD.04744.4732C8E5; Tue,  7 Apr 2020 15:53:40 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20200407065340epcas1p13e6e5ad6131f0a94d3ed1e8360353a82~DdxOq9kmZ1177111771epcas1p1W;
        Tue,  7 Apr 2020 06:53:40 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20200407065340epsmtrp2fd6b44677cbbdd43f51ab5891ce1972a~DdxOqB1UI2992929929epsmtrp2P;
        Tue,  7 Apr 2020 06:53:40 +0000 (GMT)
X-AuditID: b6c32a38-26bff70000001288-00-5e8c2374195e
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        6C.02.04158.3732C8E5; Tue,  7 Apr 2020 15:53:40 +0900 (KST)
Received: from [10.253.105.163] (unknown [10.253.105.163]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20200407065339epsmtip26053ab6019e61953f3103c48aef31168~DdxOggBwS1741817418epsmtip2Z;
        Tue,  7 Apr 2020 06:53:39 +0000 (GMT)
From:   Sunwook Eom <speed.eom@samsung.com>
Subject: [PATCH] dm verity fec: Don't add data_blocks to block
To:     agk@redhat.com
Cc:     snitzer@redhat.com, dm-devel@redhat.com,
        linux-kernel@vger.kernel.org, sunwook5492@gmail.com
Message-ID: <317e0073-a6f7-4232-3b95-a4bc3ddbcdec@samsung.com>
Date:   Tue, 7 Apr 2020 15:53:35 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.9.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprIJsWRmVeSWpSXmKPExsWy7bCmgW6Jck+cwYQtWhbrTx1jttj7bjar
        xeVdc9gs2jZ+ZbTo37+BzYHVY+esu+we7/ddZfP4vEkugDkqxyYjNTEltUghNS85PyUzL91W
        yTs43jne1MzAUNfQ0sJcSSEvMTfVVsnFJ0DXLTMHaKWSQlliTilQKCCxuFhJ386mKL+0JFUh
        I7+4xFYptSAlp8DQoECvODG3uDQvXS85P9fK0MDAyBSoMiEnY+6ErSwF5+Qq1r9czd7A2CXV
        xcjJISFgIvF2zi62LkYuDiGBHYwSXS9fQDmfGCUa/j1khXC+MUps75vEBNNyo2MRVGIvo8SD
        G3OZIJz3jBL9i/eygFSxCWhKHOo5BmYLC9hJbL3/kRHEFhEQkpg+twfMZhZIkujsegY2lReo
        5v77l8wgNouAisSPBe/ZQWxRgQiJe0sPMkPUCEqcnPmEBaJXXqJ562xmCFtc4taT+WBHSAis
        YJN4sxuiQULAReLF9r9QZwtLvDq+hR3ClpL4/G4vG4RdLXHlxEWomhqJ3uu3WCFsY4nengtA
        cziAFmhKrN+lDxFWlNj5ey7U/XwS7772sIKUSAjwSnS0CUGUKEu8PX6eBcKWlDj9dyrURA+J
        U0/us4OUCwnESlyYHTmBUWEWksdmIXlsFpLHZiHcsICRZRWjWGpBcW56arFhgQlyZG9iBCdH
        LYsdjHvO+RxiFOBgVOLhjeDsjhNiTSwrrsw9xCjBwawkwivV2xknxJuSWFmVWpQfX1Sak1p8
        iNEUGO4TmaVEk/OBiTuvJN7Q1MjY2NjCxMzczNRYSZx36vWcOCGB9MSS1OzU1ILUIpg+Jg5O
        qQZGV1OngLh/rxXvXN4+70HsrqszTtjc4SioKjuUmJk5/17Nngaliz5BC/hs58rK3u64/jh8
        VY1VhZX2st3hsyS7L560yZdwkZYO1NC7l93NnOsS27enosexRebeXTtrz6VZHQuUnLSWXDts
        ueD187Pz5n++fFNi6+RTV9TELbYsVJ+bH+WSmfJEiaU4I9FQi7moOBEAFTczTqQDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrGLMWRmVeSWpSXmKPExsWy7bCSvG6Jck+cwcI1LBbrTx1jttj7bjar
        xeVdc9gs2jZ+ZbTo37+BzYHVY+esu+we7/ddZfP4vEkugDmKyyYlNSezLLVI3y6BK2PuhK0s
        BefkKta/XM3ewNgl1cXIySEhYCJxo2MRaxcjF4eQwG5GiVfHdrBCJCQl3jRdZuxi5ACyhSUO
        Hy4GCQsJvGWUmHCQCcRmE9CUONRzjAXEFhawk9h6/yMjiC0iICQxfW4PmM0skCQxZdUJsHpe
        oJr7718yg9gsAioSPxa8ZwexRQUiJFrv3mKGqBGUODnzCQtEr5nEvM0PmSFseYnmrbOhbHGJ
        W0/mM01gFJiFpGUWkpZZSFpmIWlZwMiyilEytaA4Nz232LDAKC+1XK84Mbe4NC9dLzk/dxMj
        OLS1tHYwnjgRf4hRgINRiYeXgb07Tog1say4MvcQowQHs5IIr1RvZ5wQb0piZVVqUX58UWlO
        avEhRmkOFiVxXvn8Y5FCAumJJanZqakFqUUwWSYOTqkGRpkQ9bDESRF3fFc1mK48w//vWb2L
        X39L3uGpyrIN/8XdHYRur18kqylnomfzyenx9PI//6MsTrHKzX5eGPqHr6+k24L3/NGahcYR
        q/jDr91YsVv2sYxQzUcT7lOzbC7H5hTFftn86scuHv3tFkKNkj2P7JZHThIM8biXpplsKHrz
        fvaVeV4JSizFGYmGWsxFxYkAPeYRlGkCAAA=
X-CMS-MailID: 20200407065340epcas1p13e6e5ad6131f0a94d3ed1e8360353a82
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20200407065340epcas1p13e6e5ad6131f0a94d3ed1e8360353a82
References: <CGME20200407065340epcas1p13e6e5ad6131f0a94d3ed1e8360353a82@epcas1p1.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Even if block type is metadata,
block in verity_fec_decode() has already the right block number.
So there is no need to add data_blocks to block.

Signed-off-by: Sunwook Eom <speed.eom@samsung.com>
---
  drivers/md/dm-verity-fec.c    | 6 +-----
  drivers/md/dm-verity-fec.h    | 4 +---
  drivers/md/dm-verity-target.c | 4 +---
  3 files changed, 3 insertions(+), 11 deletions(-)

diff --git a/drivers/md/dm-verity-fec.c b/drivers/md/dm-verity-fec.c
index 49147e634046..55f353cae6ec 100644
--- a/drivers/md/dm-verity-fec.c
+++ b/drivers/md/dm-verity-fec.c
@@ -417,8 +417,7 @@ static int fec_bv_copy(struct dm_verity *v, struct 
dm_verity_io *io, u8 *data,
   * otherwise to a bio_vec starting from iter.
   */
  int verity_fec_decode(struct dm_verity *v, struct dm_verity_io *io,
-              enum verity_block_type type, sector_t block, u8 *dest,
-              struct bvec_iter *iter)
+              sector_t block, u8 *dest, struct bvec_iter *iter)
  {
      int r;
      struct dm_verity_fec_io *fio = fec_io(io);
@@ -434,9 +433,6 @@ int verity_fec_decode(struct dm_verity *v, struct 
dm_verity_io *io,

      fio->level++;

-    if (type == DM_VERITY_BLOCK_TYPE_METADATA)
-        block += v->data_blocks;
-
      /*
       * For RS(M, N), the continuous FEC data is divided into blocks of N
       * bytes. Since block size may not be divisible by N, the last block
diff --git a/drivers/md/dm-verity-fec.h b/drivers/md/dm-verity-fec.h
index 42fbd3a7fc9f..7e2fea0f8cbf 100644
--- a/drivers/md/dm-verity-fec.h
+++ b/drivers/md/dm-verity-fec.h
@@ -68,8 +68,7 @@ struct dm_verity_fec_io {
  extern bool verity_fec_is_enabled(struct dm_verity *v);

  extern int verity_fec_decode(struct dm_verity *v, struct dm_verity_io *io,
-                 enum verity_block_type type, sector_t block,
-                 u8 *dest, struct bvec_iter *iter);
+                 sector_t block, u8 *dest, struct bvec_iter *iter);

  extern unsigned verity_fec_status_table(struct dm_verity *v, unsigned sz,
                      char *result, unsigned maxlen);
@@ -98,7 +97,6 @@ static inline bool verity_fec_is_enabled(struct 
dm_verity *v)

  static inline int verity_fec_decode(struct dm_verity *v,
                      struct dm_verity_io *io,
-                    enum verity_block_type type,
                      sector_t block, u8 *dest,
                      struct bvec_iter *iter)
  {
diff --git a/drivers/md/dm-verity-target.c b/drivers/md/dm-verity-target.c
index eec9f252e935..a91b4cb2bf54 100644
--- a/drivers/md/dm-verity-target.c
+++ b/drivers/md/dm-verity-target.c
@@ -303,7 +303,6 @@ static int verity_verify_level(struct dm_verity *v, 
struct dm_verity_io *io,
                    v->digest_size) == 0))
              aux->hash_verified = 1;
          else if (verity_fec_decode(v, io,
-                       DM_VERITY_BLOCK_TYPE_METADATA,
                         hash_block, data, NULL) == 0)
              aux->hash_verified = 1;
          else if (verity_handle_err(v,
@@ -521,8 +520,7 @@ static int verity_verify_io(struct dm_verity_io *io)
              if (v->validated_blocks)
                  set_bit(cur_block, v->validated_blocks);
              continue;
-        }
-        else if (verity_fec_decode(v, io, DM_VERITY_BLOCK_TYPE_DATA,
+        } else if (verity_fec_decode(v, io,
                         cur_block, NULL, &start) == 0)
              continue;
          else if (verity_handle_err(v, DM_VERITY_BLOCK_TYPE_DATA,
-- 
2.17.1

