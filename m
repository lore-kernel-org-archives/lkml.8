Return-Path: <SRS0=pQss=CP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 393E4C433E2
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Sep 2020 08:29:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D09EE2074D
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Sep 2020 08:29:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726890AbgIFI3V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 6 Sep 2020 04:29:21 -0400
Received: from mga05.intel.com ([192.55.52.43]:17536 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725497AbgIFI3O (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Sep 2020 04:29:14 -0400
IronPort-SDR: /UIWA6Y4aNbi3ln5tWkupvLgqO5StTNBAAvL1kNb3FlK6sRBup4bETHdi7awK4Hijl7aZXBPze
 Ap9H1c02SdYg==
X-IronPort-AV: E=McAfee;i="6000,8403,9735"; a="242714870"
X-IronPort-AV: E=Sophos;i="5.76,397,1592895600"; 
   d="gz'50?scan'50,208,50";a="242714870"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Sep 2020 01:28:57 -0700
IronPort-SDR: KFsENnpIbn30cis+/+DlIdMPRtyL/6t8XUCDe4diE7KH1it1g2kqFTiAF1a1PRth2w4G7LxtkL
 7T1NsMFAS6pQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,397,1592895600"; 
   d="gz'50?scan'50,208,50";a="303300192"
Received: from lkp-server01.sh.intel.com (HELO 4b5d6de90563) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 06 Sep 2020 01:28:55 -0700
Received: from kbuild by 4b5d6de90563 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1kEq2g-00009n-On; Sun, 06 Sep 2020 08:28:54 +0000
Date:   Sun, 6 Sep 2020 16:28:43 +0800
From:   kernel test robot <lkp@intel.com>
To:     Corentin Labbe <clabbe.montjoie@gmail.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Herbert Xu <herbert@gondor.apana.org.au>
Subject: drivers/crypto/allwinner/sun4i-ss/sun4i-ss-hash.c:412:28: sparse:
 sparse: invalid assignment: &=
Message-ID: <202009061641.svGczCRM%lkp@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="9amGYk9869ThD9tj"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--9amGYk9869ThD9tj
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   dd9fb9bb3340c791a2be106fdc895db75f177343
commit: d1d787bcebfe122a5bd443ae565696661e2e9656 crypto: sun4i-ss - fix big endian issues
date:   10 months ago
config: arm64-randconfig-s031-20200906 (attached as .config)
compiler: aarch64-linux-gcc (GCC) 9.3.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.2-191-g10164920-dirty
        git checkout d1d787bcebfe122a5bd443ae565696661e2e9656
        # save the attached .config to linux build tree
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' ARCH=arm64 

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)

>> drivers/crypto/allwinner/sun4i-ss/sun4i-ss-hash.c:412:28: sparse: sparse: invalid assignment: &=
>> drivers/crypto/allwinner/sun4i-ss/sun4i-ss-hash.c:412:28: sparse:    left side has type restricted __le32
>> drivers/crypto/allwinner/sun4i-ss/sun4i-ss-hash.c:412:28: sparse:    right side has type unsigned long
   drivers/crypto/allwinner/sun4i-ss/sun4i-ss-hash.c:419:12: sparse: sparse: invalid assignment: |=
   drivers/crypto/allwinner/sun4i-ss/sun4i-ss-hash.c:419:12: sparse:    left side has type restricted __le32
>> drivers/crypto/allwinner/sun4i-ss/sun4i-ss-hash.c:419:12: sparse:    right side has type int
   drivers/crypto/allwinner/sun4i-ss/sun4i-ss-hash.c:482:27: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [assigned] [usertype] v @@     got restricted __be32 [usertype] @@
   drivers/crypto/allwinner/sun4i-ss/sun4i-ss-hash.c:482:27: sparse:     expected unsigned int [assigned] [usertype] v
   drivers/crypto/allwinner/sun4i-ss/sun4i-ss-hash.c:482:27: sparse:     got restricted __be32 [usertype]
>> drivers/crypto/allwinner/sun4i-ss/sun4i-ss-hash.c:487:27: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [addressable] [assigned] [usertype] v @@     got restricted __le32 [usertype] @@
>> drivers/crypto/allwinner/sun4i-ss/sun4i-ss-hash.c:487:27: sparse:     expected unsigned int [addressable] [assigned] [usertype] v
>> drivers/crypto/allwinner/sun4i-ss/sun4i-ss-hash.c:487:27: sparse:     got restricted __le32 [usertype]

# https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=d1d787bcebfe122a5bd443ae565696661e2e9656
git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
git fetch --no-tags linus master
git checkout d1d787bcebfe122a5bd443ae565696661e2e9656
vim +412 drivers/crypto/allwinner/sun4i-ss/sun4i-ss-hash.c

477d9b2e591b8d drivers/crypto/sunxi-ss/sun4i-ss-hash.c           Corentin LABBE 2016-08-10  148  
6298e948215f2a drivers/crypto/sunxi-ss/sun4i-ss-hash.c           LABBE Corentin 2015-07-17  149  /*
6298e948215f2a drivers/crypto/sunxi-ss/sun4i-ss-hash.c           LABBE Corentin 2015-07-17  150   * sun4i_hash_update: update hash engine
6298e948215f2a drivers/crypto/sunxi-ss/sun4i-ss-hash.c           LABBE Corentin 2015-07-17  151   *
6298e948215f2a drivers/crypto/sunxi-ss/sun4i-ss-hash.c           LABBE Corentin 2015-07-17  152   * Could be used for both SHA1 and MD5
6298e948215f2a drivers/crypto/sunxi-ss/sun4i-ss-hash.c           LABBE Corentin 2015-07-17  153   * Write data by step of 32bits and put then in the SS.
6298e948215f2a drivers/crypto/sunxi-ss/sun4i-ss-hash.c           LABBE Corentin 2015-07-17  154   *
6298e948215f2a drivers/crypto/sunxi-ss/sun4i-ss-hash.c           LABBE Corentin 2015-07-17  155   * Since we cannot leave partial data and hash state in the engine,
6298e948215f2a drivers/crypto/sunxi-ss/sun4i-ss-hash.c           LABBE Corentin 2015-07-17  156   * we need to get the hash state at the end of this function.
6298e948215f2a drivers/crypto/sunxi-ss/sun4i-ss-hash.c           LABBE Corentin 2015-07-17  157   * We can get the hash state every 64 bytes
6298e948215f2a drivers/crypto/sunxi-ss/sun4i-ss-hash.c           LABBE Corentin 2015-07-17  158   *
6298e948215f2a drivers/crypto/sunxi-ss/sun4i-ss-hash.c           LABBE Corentin 2015-07-17  159   * So the first work is to get the number of bytes to write to SS modulo 64
6298e948215f2a drivers/crypto/sunxi-ss/sun4i-ss-hash.c           LABBE Corentin 2015-07-17  160   * The extra bytes will go to a temporary buffer op->buf storing op->len bytes
6298e948215f2a drivers/crypto/sunxi-ss/sun4i-ss-hash.c           LABBE Corentin 2015-07-17  161   *
6298e948215f2a drivers/crypto/sunxi-ss/sun4i-ss-hash.c           LABBE Corentin 2015-07-17  162   * So at the begin of update()
6298e948215f2a drivers/crypto/sunxi-ss/sun4i-ss-hash.c           LABBE Corentin 2015-07-17  163   * if op->len + areq->nbytes < 64
6298e948215f2a drivers/crypto/sunxi-ss/sun4i-ss-hash.c           LABBE Corentin 2015-07-17  164   * => all data will be written to wait buffer (op->buf) and end=0
6298e948215f2a drivers/crypto/sunxi-ss/sun4i-ss-hash.c           LABBE Corentin 2015-07-17  165   * if not, write all data from op->buf to the device and position end to
6298e948215f2a drivers/crypto/sunxi-ss/sun4i-ss-hash.c           LABBE Corentin 2015-07-17  166   * complete to 64bytes
6298e948215f2a drivers/crypto/sunxi-ss/sun4i-ss-hash.c           LABBE Corentin 2015-07-17  167   *
6298e948215f2a drivers/crypto/sunxi-ss/sun4i-ss-hash.c           LABBE Corentin 2015-07-17  168   * example 1:
6298e948215f2a drivers/crypto/sunxi-ss/sun4i-ss-hash.c           LABBE Corentin 2015-07-17  169   * update1 60o => op->len=60
6298e948215f2a drivers/crypto/sunxi-ss/sun4i-ss-hash.c           LABBE Corentin 2015-07-17  170   * update2 60o => need one more word to have 64 bytes
6298e948215f2a drivers/crypto/sunxi-ss/sun4i-ss-hash.c           LABBE Corentin 2015-07-17  171   * end=4
6298e948215f2a drivers/crypto/sunxi-ss/sun4i-ss-hash.c           LABBE Corentin 2015-07-17  172   * so write all data from op->buf and one word of SGs
6298e948215f2a drivers/crypto/sunxi-ss/sun4i-ss-hash.c           LABBE Corentin 2015-07-17  173   * write remaining data in op->buf
6298e948215f2a drivers/crypto/sunxi-ss/sun4i-ss-hash.c           LABBE Corentin 2015-07-17  174   * final state op->len=56
6298e948215f2a drivers/crypto/sunxi-ss/sun4i-ss-hash.c           LABBE Corentin 2015-07-17  175   */
8d46a5c872946a drivers/crypto/sunxi-ss/sun4i-ss-hash.c           Baoyou Xie     2016-09-18  176  static int sun4i_hash(struct ahash_request *areq)
6298e948215f2a drivers/crypto/sunxi-ss/sun4i-ss-hash.c           LABBE Corentin 2015-07-17  177  {
6298e948215f2a drivers/crypto/sunxi-ss/sun4i-ss-hash.c           LABBE Corentin 2015-07-17  178  	/*
6298e948215f2a drivers/crypto/sunxi-ss/sun4i-ss-hash.c           LABBE Corentin 2015-07-17  179  	 * i is the total bytes read from SGs, to be compared to areq->nbytes
6298e948215f2a drivers/crypto/sunxi-ss/sun4i-ss-hash.c           LABBE Corentin 2015-07-17  180  	 * i is important because we cannot rely on SG length since the sum of
6298e948215f2a drivers/crypto/sunxi-ss/sun4i-ss-hash.c           LABBE Corentin 2015-07-17  181  	 * SG->length could be greater than areq->nbytes
e3f9490e89c224 drivers/crypto/sunxi-ss/sun4i-ss-hash.c           Antoine Tenart 2017-06-01  182  	 *
e3f9490e89c224 drivers/crypto/sunxi-ss/sun4i-ss-hash.c           Antoine Tenart 2017-06-01  183  	 * end is the position when we need to stop writing to the device,
e3f9490e89c224 drivers/crypto/sunxi-ss/sun4i-ss-hash.c           Antoine Tenart 2017-06-01  184  	 * to be compared to i
e3f9490e89c224 drivers/crypto/sunxi-ss/sun4i-ss-hash.c           Antoine Tenart 2017-06-01  185  	 *
e3f9490e89c224 drivers/crypto/sunxi-ss/sun4i-ss-hash.c           Antoine Tenart 2017-06-01  186  	 * in_i: advancement in the current SG
6298e948215f2a drivers/crypto/sunxi-ss/sun4i-ss-hash.c           LABBE Corentin 2015-07-17  187  	 */
214a9bd0f8dec4 drivers/crypto/sunxi-ss/sun4i-ss-hash.c           Antoine Tenart 2017-06-01  188  	unsigned int i = 0, end, fill, min_fill, nwait, nbw = 0, j = 0, todo;
e3f9490e89c224 drivers/crypto/sunxi-ss/sun4i-ss-hash.c           Antoine Tenart 2017-06-01  189  	unsigned int in_i = 0;
d1d787bcebfe12 drivers/crypto/allwinner/sun4i-ss/sun4i-ss-hash.c Corentin Labbe 2019-11-14  190  	u32 spaces, rx_cnt = SS_RX_DEFAULT, bf[32] = {0}, v, ivmode = 0;
6298e948215f2a drivers/crypto/sunxi-ss/sun4i-ss-hash.c           LABBE Corentin 2015-07-17  191  	struct sun4i_req_ctx *op = ahash_request_ctx(areq);
6298e948215f2a drivers/crypto/sunxi-ss/sun4i-ss-hash.c           LABBE Corentin 2015-07-17  192  	struct crypto_ahash *tfm = crypto_ahash_reqtfm(areq);
9b17e5ad7831cd drivers/crypto/sunxi-ss/sun4i-ss-hash.c           Corentin LABBE 2016-08-10  193  	struct sun4i_tfm_ctx *tfmctx = crypto_ahash_ctx(tfm);
9b17e5ad7831cd drivers/crypto/sunxi-ss/sun4i-ss-hash.c           Corentin LABBE 2016-08-10  194  	struct sun4i_ss_ctx *ss = tfmctx->ss;
e3f9490e89c224 drivers/crypto/sunxi-ss/sun4i-ss-hash.c           Antoine Tenart 2017-06-01  195  	struct scatterlist *in_sg = areq->src;
6298e948215f2a drivers/crypto/sunxi-ss/sun4i-ss-hash.c           LABBE Corentin 2015-07-17  196  	struct sg_mapping_iter mi;
214a9bd0f8dec4 drivers/crypto/sunxi-ss/sun4i-ss-hash.c           Antoine Tenart 2017-06-01  197  	int in_r, err = 0;
e3f9490e89c224 drivers/crypto/sunxi-ss/sun4i-ss-hash.c           Antoine Tenart 2017-06-01  198  	size_t copied = 0;
d1d787bcebfe12 drivers/crypto/allwinner/sun4i-ss/sun4i-ss-hash.c Corentin Labbe 2019-11-14  199  	__le32 wb = 0;
6298e948215f2a drivers/crypto/sunxi-ss/sun4i-ss-hash.c           LABBE Corentin 2015-07-17  200  
6298e948215f2a drivers/crypto/sunxi-ss/sun4i-ss-hash.c           LABBE Corentin 2015-07-17  201  	dev_dbg(ss->dev, "%s %s bc=%llu len=%u mode=%x wl=%u h0=%0x",
6298e948215f2a drivers/crypto/sunxi-ss/sun4i-ss-hash.c           LABBE Corentin 2015-07-17  202  		__func__, crypto_tfm_alg_name(areq->base.tfm),
6298e948215f2a drivers/crypto/sunxi-ss/sun4i-ss-hash.c           LABBE Corentin 2015-07-17  203  		op->byte_count, areq->nbytes, op->mode,
6298e948215f2a drivers/crypto/sunxi-ss/sun4i-ss-hash.c           LABBE Corentin 2015-07-17  204  		op->len, op->hash[0]);
6298e948215f2a drivers/crypto/sunxi-ss/sun4i-ss-hash.c           LABBE Corentin 2015-07-17  205  
a595e60a70c0d0 drivers/crypto/sunxi-ss/sun4i-ss-hash.c           Antoine Tenart 2017-06-01  206  	if (unlikely(!areq->nbytes) && !(op->flags & SS_HASH_FINAL))
6298e948215f2a drivers/crypto/sunxi-ss/sun4i-ss-hash.c           LABBE Corentin 2015-07-17  207  		return 0;
6298e948215f2a drivers/crypto/sunxi-ss/sun4i-ss-hash.c           LABBE Corentin 2015-07-17  208  
6298e948215f2a drivers/crypto/sunxi-ss/sun4i-ss-hash.c           LABBE Corentin 2015-07-17  209  	/* protect against overflow */
477d9b2e591b8d drivers/crypto/sunxi-ss/sun4i-ss-hash.c           Corentin LABBE 2016-08-10  210  	if (unlikely(areq->nbytes > UINT_MAX - op->len)) {
6298e948215f2a drivers/crypto/sunxi-ss/sun4i-ss-hash.c           LABBE Corentin 2015-07-17  211  		dev_err(ss->dev, "Cannot process too large request\n");
6298e948215f2a drivers/crypto/sunxi-ss/sun4i-ss-hash.c           LABBE Corentin 2015-07-17  212  		return -EINVAL;
6298e948215f2a drivers/crypto/sunxi-ss/sun4i-ss-hash.c           LABBE Corentin 2015-07-17  213  	}
6298e948215f2a drivers/crypto/sunxi-ss/sun4i-ss-hash.c           LABBE Corentin 2015-07-17  214  
a595e60a70c0d0 drivers/crypto/sunxi-ss/sun4i-ss-hash.c           Antoine Tenart 2017-06-01  215  	if (op->len + areq->nbytes < 64 && !(op->flags & SS_HASH_FINAL)) {
6298e948215f2a drivers/crypto/sunxi-ss/sun4i-ss-hash.c           LABBE Corentin 2015-07-17  216  		/* linearize data to op->buf */
6298e948215f2a drivers/crypto/sunxi-ss/sun4i-ss-hash.c           LABBE Corentin 2015-07-17  217  		copied = sg_pcopy_to_buffer(areq->src, sg_nents(areq->src),
6298e948215f2a drivers/crypto/sunxi-ss/sun4i-ss-hash.c           LABBE Corentin 2015-07-17  218  					    op->buf + op->len, areq->nbytes, 0);
6298e948215f2a drivers/crypto/sunxi-ss/sun4i-ss-hash.c           LABBE Corentin 2015-07-17  219  		op->len += copied;
6298e948215f2a drivers/crypto/sunxi-ss/sun4i-ss-hash.c           LABBE Corentin 2015-07-17  220  		return 0;
6298e948215f2a drivers/crypto/sunxi-ss/sun4i-ss-hash.c           LABBE Corentin 2015-07-17  221  	}
6298e948215f2a drivers/crypto/sunxi-ss/sun4i-ss-hash.c           LABBE Corentin 2015-07-17  222  
6298e948215f2a drivers/crypto/sunxi-ss/sun4i-ss-hash.c           LABBE Corentin 2015-07-17  223  	spin_lock_bh(&ss->slock);
6298e948215f2a drivers/crypto/sunxi-ss/sun4i-ss-hash.c           LABBE Corentin 2015-07-17  224  
6298e948215f2a drivers/crypto/sunxi-ss/sun4i-ss-hash.c           LABBE Corentin 2015-07-17  225  	/*
6298e948215f2a drivers/crypto/sunxi-ss/sun4i-ss-hash.c           LABBE Corentin 2015-07-17  226  	 * if some data have been processed before,
6298e948215f2a drivers/crypto/sunxi-ss/sun4i-ss-hash.c           LABBE Corentin 2015-07-17  227  	 * we need to restore the partial hash state
6298e948215f2a drivers/crypto/sunxi-ss/sun4i-ss-hash.c           LABBE Corentin 2015-07-17  228  	 */
a595e60a70c0d0 drivers/crypto/sunxi-ss/sun4i-ss-hash.c           Antoine Tenart 2017-06-01  229  	if (op->byte_count) {
6298e948215f2a drivers/crypto/sunxi-ss/sun4i-ss-hash.c           LABBE Corentin 2015-07-17  230  		ivmode = SS_IV_ARBITRARY;
626abd3125e02d drivers/crypto/allwinner/sun4i-ss/sun4i-ss-hash.c Corentin Labbe 2019-11-14  231  		for (i = 0; i < crypto_ahash_digestsize(tfm) / 4; i++)
6298e948215f2a drivers/crypto/sunxi-ss/sun4i-ss-hash.c           LABBE Corentin 2015-07-17  232  			writel(op->hash[i], ss->base + SS_IV0 + i * 4);
6298e948215f2a drivers/crypto/sunxi-ss/sun4i-ss-hash.c           LABBE Corentin 2015-07-17  233  	}
6298e948215f2a drivers/crypto/sunxi-ss/sun4i-ss-hash.c           LABBE Corentin 2015-07-17  234  	/* Enable the device */
6298e948215f2a drivers/crypto/sunxi-ss/sun4i-ss-hash.c           LABBE Corentin 2015-07-17  235  	writel(op->mode | SS_ENABLED | ivmode, ss->base + SS_CTL);
6298e948215f2a drivers/crypto/sunxi-ss/sun4i-ss-hash.c           LABBE Corentin 2015-07-17  236  
a595e60a70c0d0 drivers/crypto/sunxi-ss/sun4i-ss-hash.c           Antoine Tenart 2017-06-01  237  	if (!(op->flags & SS_HASH_UPDATE))
477d9b2e591b8d drivers/crypto/sunxi-ss/sun4i-ss-hash.c           Corentin LABBE 2016-08-10  238  		goto hash_final;
477d9b2e591b8d drivers/crypto/sunxi-ss/sun4i-ss-hash.c           Corentin LABBE 2016-08-10  239  
477d9b2e591b8d drivers/crypto/sunxi-ss/sun4i-ss-hash.c           Corentin LABBE 2016-08-10  240  	/* start of handling data */
a595e60a70c0d0 drivers/crypto/sunxi-ss/sun4i-ss-hash.c           Antoine Tenart 2017-06-01  241  	if (!(op->flags & SS_HASH_FINAL)) {
477d9b2e591b8d drivers/crypto/sunxi-ss/sun4i-ss-hash.c           Corentin LABBE 2016-08-10  242  		end = ((areq->nbytes + op->len) / 64) * 64 - op->len;
477d9b2e591b8d drivers/crypto/sunxi-ss/sun4i-ss-hash.c           Corentin LABBE 2016-08-10  243  
477d9b2e591b8d drivers/crypto/sunxi-ss/sun4i-ss-hash.c           Corentin LABBE 2016-08-10  244  		if (end > areq->nbytes || areq->nbytes - end > 63) {
477d9b2e591b8d drivers/crypto/sunxi-ss/sun4i-ss-hash.c           Corentin LABBE 2016-08-10  245  			dev_err(ss->dev, "ERROR: Bound error %u %u\n",
477d9b2e591b8d drivers/crypto/sunxi-ss/sun4i-ss-hash.c           Corentin LABBE 2016-08-10  246  				end, areq->nbytes);
b46b9d1aadf7f3 drivers/crypto/sunxi-ss/sun4i-ss-hash.c           Wei Yongjun    2016-08-20  247  			err = -EINVAL;
b46b9d1aadf7f3 drivers/crypto/sunxi-ss/sun4i-ss-hash.c           Wei Yongjun    2016-08-20  248  			goto release_ss;
477d9b2e591b8d drivers/crypto/sunxi-ss/sun4i-ss-hash.c           Corentin LABBE 2016-08-10  249  		}
477d9b2e591b8d drivers/crypto/sunxi-ss/sun4i-ss-hash.c           Corentin LABBE 2016-08-10  250  	} else {
477d9b2e591b8d drivers/crypto/sunxi-ss/sun4i-ss-hash.c           Corentin LABBE 2016-08-10  251  		/* Since we have the flag final, we can go up to modulo 4 */
f87391558acf81 drivers/crypto/sunxi-ss/sun4i-ss-hash.c           Corentin Labbe 2019-04-18  252  		if (areq->nbytes < 4)
f87391558acf81 drivers/crypto/sunxi-ss/sun4i-ss-hash.c           Corentin Labbe 2019-04-18  253  			end = 0;
f87391558acf81 drivers/crypto/sunxi-ss/sun4i-ss-hash.c           Corentin Labbe 2019-04-18  254  		else
477d9b2e591b8d drivers/crypto/sunxi-ss/sun4i-ss-hash.c           Corentin LABBE 2016-08-10  255  			end = ((areq->nbytes + op->len) / 4) * 4 - op->len;
477d9b2e591b8d drivers/crypto/sunxi-ss/sun4i-ss-hash.c           Corentin LABBE 2016-08-10  256  	}
477d9b2e591b8d drivers/crypto/sunxi-ss/sun4i-ss-hash.c           Corentin LABBE 2016-08-10  257  
a595e60a70c0d0 drivers/crypto/sunxi-ss/sun4i-ss-hash.c           Antoine Tenart 2017-06-01  258  	/* TODO if SGlen % 4 and !op->len then DMA */
477d9b2e591b8d drivers/crypto/sunxi-ss/sun4i-ss-hash.c           Corentin LABBE 2016-08-10  259  	i = 1;
477d9b2e591b8d drivers/crypto/sunxi-ss/sun4i-ss-hash.c           Corentin LABBE 2016-08-10  260  	while (in_sg && i == 1) {
a595e60a70c0d0 drivers/crypto/sunxi-ss/sun4i-ss-hash.c           Antoine Tenart 2017-06-01  261  		if (in_sg->length % 4)
477d9b2e591b8d drivers/crypto/sunxi-ss/sun4i-ss-hash.c           Corentin LABBE 2016-08-10  262  			i = 0;
477d9b2e591b8d drivers/crypto/sunxi-ss/sun4i-ss-hash.c           Corentin LABBE 2016-08-10  263  		in_sg = sg_next(in_sg);
477d9b2e591b8d drivers/crypto/sunxi-ss/sun4i-ss-hash.c           Corentin LABBE 2016-08-10  264  	}
0f52ddaed6500d drivers/crypto/sunxi-ss/sun4i-ss-hash.c           Antoine Tenart 2017-06-01  265  	if (i == 1 && !op->len && areq->nbytes)
477d9b2e591b8d drivers/crypto/sunxi-ss/sun4i-ss-hash.c           Corentin LABBE 2016-08-10  266  		dev_dbg(ss->dev, "We can DMA\n");
477d9b2e591b8d drivers/crypto/sunxi-ss/sun4i-ss-hash.c           Corentin LABBE 2016-08-10  267  
6298e948215f2a drivers/crypto/sunxi-ss/sun4i-ss-hash.c           LABBE Corentin 2015-07-17  268  	i = 0;
6298e948215f2a drivers/crypto/sunxi-ss/sun4i-ss-hash.c           LABBE Corentin 2015-07-17  269  	sg_miter_start(&mi, areq->src, sg_nents(areq->src),
6298e948215f2a drivers/crypto/sunxi-ss/sun4i-ss-hash.c           LABBE Corentin 2015-07-17  270  		       SG_MITER_FROM_SG | SG_MITER_ATOMIC);
6298e948215f2a drivers/crypto/sunxi-ss/sun4i-ss-hash.c           LABBE Corentin 2015-07-17  271  	sg_miter_next(&mi);
6298e948215f2a drivers/crypto/sunxi-ss/sun4i-ss-hash.c           LABBE Corentin 2015-07-17  272  	in_i = 0;
6298e948215f2a drivers/crypto/sunxi-ss/sun4i-ss-hash.c           LABBE Corentin 2015-07-17  273  
6298e948215f2a drivers/crypto/sunxi-ss/sun4i-ss-hash.c           LABBE Corentin 2015-07-17  274  	do {
6298e948215f2a drivers/crypto/sunxi-ss/sun4i-ss-hash.c           LABBE Corentin 2015-07-17  275  		/*
6298e948215f2a drivers/crypto/sunxi-ss/sun4i-ss-hash.c           LABBE Corentin 2015-07-17  276  		 * we need to linearize in two case:
6298e948215f2a drivers/crypto/sunxi-ss/sun4i-ss-hash.c           LABBE Corentin 2015-07-17  277  		 * - the buffer is already used
6298e948215f2a drivers/crypto/sunxi-ss/sun4i-ss-hash.c           LABBE Corentin 2015-07-17  278  		 * - the SG does not have enough byte remaining ( < 4)
6298e948215f2a drivers/crypto/sunxi-ss/sun4i-ss-hash.c           LABBE Corentin 2015-07-17  279  		 */
a595e60a70c0d0 drivers/crypto/sunxi-ss/sun4i-ss-hash.c           Antoine Tenart 2017-06-01  280  		if (op->len || (mi.length - in_i) < 4) {
6298e948215f2a drivers/crypto/sunxi-ss/sun4i-ss-hash.c           LABBE Corentin 2015-07-17  281  			/*
6298e948215f2a drivers/crypto/sunxi-ss/sun4i-ss-hash.c           LABBE Corentin 2015-07-17  282  			 * if we have entered here we have two reason to stop
6298e948215f2a drivers/crypto/sunxi-ss/sun4i-ss-hash.c           LABBE Corentin 2015-07-17  283  			 * - the buffer is full
6298e948215f2a drivers/crypto/sunxi-ss/sun4i-ss-hash.c           LABBE Corentin 2015-07-17  284  			 * - reach the end
6298e948215f2a drivers/crypto/sunxi-ss/sun4i-ss-hash.c           LABBE Corentin 2015-07-17  285  			 */
6298e948215f2a drivers/crypto/sunxi-ss/sun4i-ss-hash.c           LABBE Corentin 2015-07-17  286  			while (op->len < 64 && i < end) {
6298e948215f2a drivers/crypto/sunxi-ss/sun4i-ss-hash.c           LABBE Corentin 2015-07-17  287  				/* how many bytes we can read from current SG */
a7126603d46fe8 drivers/crypto/allwinner/sun4i-ss/sun4i-ss-hash.c Corentin Labbe 2019-11-14  288  				in_r = min(end - i, 64 - op->len);
a7126603d46fe8 drivers/crypto/allwinner/sun4i-ss/sun4i-ss-hash.c Corentin Labbe 2019-11-14  289  				in_r = min_t(size_t, mi.length - in_i, in_r);
6298e948215f2a drivers/crypto/sunxi-ss/sun4i-ss-hash.c           LABBE Corentin 2015-07-17  290  				memcpy(op->buf + op->len, mi.addr + in_i, in_r);
6298e948215f2a drivers/crypto/sunxi-ss/sun4i-ss-hash.c           LABBE Corentin 2015-07-17  291  				op->len += in_r;
6298e948215f2a drivers/crypto/sunxi-ss/sun4i-ss-hash.c           LABBE Corentin 2015-07-17  292  				i += in_r;
6298e948215f2a drivers/crypto/sunxi-ss/sun4i-ss-hash.c           LABBE Corentin 2015-07-17  293  				in_i += in_r;
6298e948215f2a drivers/crypto/sunxi-ss/sun4i-ss-hash.c           LABBE Corentin 2015-07-17  294  				if (in_i == mi.length) {
6298e948215f2a drivers/crypto/sunxi-ss/sun4i-ss-hash.c           LABBE Corentin 2015-07-17  295  					sg_miter_next(&mi);
6298e948215f2a drivers/crypto/sunxi-ss/sun4i-ss-hash.c           LABBE Corentin 2015-07-17  296  					in_i = 0;
6298e948215f2a drivers/crypto/sunxi-ss/sun4i-ss-hash.c           LABBE Corentin 2015-07-17  297  				}
6298e948215f2a drivers/crypto/sunxi-ss/sun4i-ss-hash.c           LABBE Corentin 2015-07-17  298  			}
a595e60a70c0d0 drivers/crypto/sunxi-ss/sun4i-ss-hash.c           Antoine Tenart 2017-06-01  299  			if (op->len > 3 && !(op->len % 4)) {
6298e948215f2a drivers/crypto/sunxi-ss/sun4i-ss-hash.c           LABBE Corentin 2015-07-17  300  				/* write buf to the device */
6298e948215f2a drivers/crypto/sunxi-ss/sun4i-ss-hash.c           LABBE Corentin 2015-07-17  301  				writesl(ss->base + SS_RXFIFO, op->buf,
6298e948215f2a drivers/crypto/sunxi-ss/sun4i-ss-hash.c           LABBE Corentin 2015-07-17  302  					op->len / 4);
6298e948215f2a drivers/crypto/sunxi-ss/sun4i-ss-hash.c           LABBE Corentin 2015-07-17  303  				op->byte_count += op->len;
6298e948215f2a drivers/crypto/sunxi-ss/sun4i-ss-hash.c           LABBE Corentin 2015-07-17  304  				op->len = 0;
6298e948215f2a drivers/crypto/sunxi-ss/sun4i-ss-hash.c           LABBE Corentin 2015-07-17  305  			}
6298e948215f2a drivers/crypto/sunxi-ss/sun4i-ss-hash.c           LABBE Corentin 2015-07-17  306  		}
6298e948215f2a drivers/crypto/sunxi-ss/sun4i-ss-hash.c           LABBE Corentin 2015-07-17  307  		if (mi.length - in_i > 3 && i < end) {
6298e948215f2a drivers/crypto/sunxi-ss/sun4i-ss-hash.c           LABBE Corentin 2015-07-17  308  			/* how many bytes we can read from current SG */
a7126603d46fe8 drivers/crypto/allwinner/sun4i-ss/sun4i-ss-hash.c Corentin Labbe 2019-11-14  309  			in_r = min_t(size_t, mi.length - in_i, areq->nbytes - i);
a7126603d46fe8 drivers/crypto/allwinner/sun4i-ss/sun4i-ss-hash.c Corentin Labbe 2019-11-14  310  			in_r = min_t(size_t, ((mi.length - in_i) / 4) * 4, in_r);
6298e948215f2a drivers/crypto/sunxi-ss/sun4i-ss-hash.c           LABBE Corentin 2015-07-17  311  			/* how many bytes we can write in the device*/
6298e948215f2a drivers/crypto/sunxi-ss/sun4i-ss-hash.c           LABBE Corentin 2015-07-17  312  			todo = min3((u32)(end - i) / 4, rx_cnt, (u32)in_r / 4);
6298e948215f2a drivers/crypto/sunxi-ss/sun4i-ss-hash.c           LABBE Corentin 2015-07-17  313  			writesl(ss->base + SS_RXFIFO, mi.addr + in_i, todo);
6298e948215f2a drivers/crypto/sunxi-ss/sun4i-ss-hash.c           LABBE Corentin 2015-07-17  314  			op->byte_count += todo * 4;
6298e948215f2a drivers/crypto/sunxi-ss/sun4i-ss-hash.c           LABBE Corentin 2015-07-17  315  			i += todo * 4;
6298e948215f2a drivers/crypto/sunxi-ss/sun4i-ss-hash.c           LABBE Corentin 2015-07-17  316  			in_i += todo * 4;
6298e948215f2a drivers/crypto/sunxi-ss/sun4i-ss-hash.c           LABBE Corentin 2015-07-17  317  			rx_cnt -= todo;
a595e60a70c0d0 drivers/crypto/sunxi-ss/sun4i-ss-hash.c           Antoine Tenart 2017-06-01  318  			if (!rx_cnt) {
6298e948215f2a drivers/crypto/sunxi-ss/sun4i-ss-hash.c           LABBE Corentin 2015-07-17  319  				spaces = readl(ss->base + SS_FCSR);
6298e948215f2a drivers/crypto/sunxi-ss/sun4i-ss-hash.c           LABBE Corentin 2015-07-17  320  				rx_cnt = SS_RXFIFO_SPACES(spaces);
6298e948215f2a drivers/crypto/sunxi-ss/sun4i-ss-hash.c           LABBE Corentin 2015-07-17  321  			}
6298e948215f2a drivers/crypto/sunxi-ss/sun4i-ss-hash.c           LABBE Corentin 2015-07-17  322  			if (in_i == mi.length) {
6298e948215f2a drivers/crypto/sunxi-ss/sun4i-ss-hash.c           LABBE Corentin 2015-07-17  323  				sg_miter_next(&mi);
6298e948215f2a drivers/crypto/sunxi-ss/sun4i-ss-hash.c           LABBE Corentin 2015-07-17  324  				in_i = 0;
6298e948215f2a drivers/crypto/sunxi-ss/sun4i-ss-hash.c           LABBE Corentin 2015-07-17  325  			}
6298e948215f2a drivers/crypto/sunxi-ss/sun4i-ss-hash.c           LABBE Corentin 2015-07-17  326  		}
6298e948215f2a drivers/crypto/sunxi-ss/sun4i-ss-hash.c           LABBE Corentin 2015-07-17  327  	} while (i < end);
477d9b2e591b8d drivers/crypto/sunxi-ss/sun4i-ss-hash.c           Corentin LABBE 2016-08-10  328  
477d9b2e591b8d drivers/crypto/sunxi-ss/sun4i-ss-hash.c           Corentin LABBE 2016-08-10  329  	/*
477d9b2e591b8d drivers/crypto/sunxi-ss/sun4i-ss-hash.c           Corentin LABBE 2016-08-10  330  	 * Now we have written to the device all that we can,
477d9b2e591b8d drivers/crypto/sunxi-ss/sun4i-ss-hash.c           Corentin LABBE 2016-08-10  331  	 * store the remaining bytes in op->buf
477d9b2e591b8d drivers/crypto/sunxi-ss/sun4i-ss-hash.c           Corentin LABBE 2016-08-10  332  	 */
6298e948215f2a drivers/crypto/sunxi-ss/sun4i-ss-hash.c           LABBE Corentin 2015-07-17  333  	if ((areq->nbytes - i) < 64) {
6298e948215f2a drivers/crypto/sunxi-ss/sun4i-ss-hash.c           LABBE Corentin 2015-07-17  334  		while (i < areq->nbytes && in_i < mi.length && op->len < 64) {
6298e948215f2a drivers/crypto/sunxi-ss/sun4i-ss-hash.c           LABBE Corentin 2015-07-17  335  			/* how many bytes we can read from current SG */
a7126603d46fe8 drivers/crypto/allwinner/sun4i-ss/sun4i-ss-hash.c Corentin Labbe 2019-11-14  336  			in_r = min(areq->nbytes - i, 64 - op->len);
a7126603d46fe8 drivers/crypto/allwinner/sun4i-ss/sun4i-ss-hash.c Corentin Labbe 2019-11-14  337  			in_r = min_t(size_t, mi.length - in_i, in_r);
6298e948215f2a drivers/crypto/sunxi-ss/sun4i-ss-hash.c           LABBE Corentin 2015-07-17  338  			memcpy(op->buf + op->len, mi.addr + in_i, in_r);
6298e948215f2a drivers/crypto/sunxi-ss/sun4i-ss-hash.c           LABBE Corentin 2015-07-17  339  			op->len += in_r;
6298e948215f2a drivers/crypto/sunxi-ss/sun4i-ss-hash.c           LABBE Corentin 2015-07-17  340  			i += in_r;
6298e948215f2a drivers/crypto/sunxi-ss/sun4i-ss-hash.c           LABBE Corentin 2015-07-17  341  			in_i += in_r;
6298e948215f2a drivers/crypto/sunxi-ss/sun4i-ss-hash.c           LABBE Corentin 2015-07-17  342  			if (in_i == mi.length) {
6298e948215f2a drivers/crypto/sunxi-ss/sun4i-ss-hash.c           LABBE Corentin 2015-07-17  343  				sg_miter_next(&mi);
6298e948215f2a drivers/crypto/sunxi-ss/sun4i-ss-hash.c           LABBE Corentin 2015-07-17  344  				in_i = 0;
6298e948215f2a drivers/crypto/sunxi-ss/sun4i-ss-hash.c           LABBE Corentin 2015-07-17  345  			}
6298e948215f2a drivers/crypto/sunxi-ss/sun4i-ss-hash.c           LABBE Corentin 2015-07-17  346  		}
6298e948215f2a drivers/crypto/sunxi-ss/sun4i-ss-hash.c           LABBE Corentin 2015-07-17  347  	}
6298e948215f2a drivers/crypto/sunxi-ss/sun4i-ss-hash.c           LABBE Corentin 2015-07-17  348  
6298e948215f2a drivers/crypto/sunxi-ss/sun4i-ss-hash.c           LABBE Corentin 2015-07-17  349  	sg_miter_stop(&mi);
6298e948215f2a drivers/crypto/sunxi-ss/sun4i-ss-hash.c           LABBE Corentin 2015-07-17  350  
477d9b2e591b8d drivers/crypto/sunxi-ss/sun4i-ss-hash.c           Corentin LABBE 2016-08-10  351  	/*
477d9b2e591b8d drivers/crypto/sunxi-ss/sun4i-ss-hash.c           Corentin LABBE 2016-08-10  352  	 * End of data process
477d9b2e591b8d drivers/crypto/sunxi-ss/sun4i-ss-hash.c           Corentin LABBE 2016-08-10  353  	 * Now if we have the flag final go to finalize part
477d9b2e591b8d drivers/crypto/sunxi-ss/sun4i-ss-hash.c           Corentin LABBE 2016-08-10  354  	 * If not, store the partial hash
477d9b2e591b8d drivers/crypto/sunxi-ss/sun4i-ss-hash.c           Corentin LABBE 2016-08-10  355  	 */
a595e60a70c0d0 drivers/crypto/sunxi-ss/sun4i-ss-hash.c           Antoine Tenart 2017-06-01  356  	if (op->flags & SS_HASH_FINAL)
477d9b2e591b8d drivers/crypto/sunxi-ss/sun4i-ss-hash.c           Corentin LABBE 2016-08-10  357  		goto hash_final;
477d9b2e591b8d drivers/crypto/sunxi-ss/sun4i-ss-hash.c           Corentin LABBE 2016-08-10  358  
6298e948215f2a drivers/crypto/sunxi-ss/sun4i-ss-hash.c           LABBE Corentin 2015-07-17  359  	writel(op->mode | SS_ENABLED | SS_DATA_END, ss->base + SS_CTL);
6298e948215f2a drivers/crypto/sunxi-ss/sun4i-ss-hash.c           LABBE Corentin 2015-07-17  360  	i = 0;
6298e948215f2a drivers/crypto/sunxi-ss/sun4i-ss-hash.c           LABBE Corentin 2015-07-17  361  	do {
6298e948215f2a drivers/crypto/sunxi-ss/sun4i-ss-hash.c           LABBE Corentin 2015-07-17  362  		v = readl(ss->base + SS_CTL);
6298e948215f2a drivers/crypto/sunxi-ss/sun4i-ss-hash.c           LABBE Corentin 2015-07-17  363  		i++;
a595e60a70c0d0 drivers/crypto/sunxi-ss/sun4i-ss-hash.c           Antoine Tenart 2017-06-01  364  	} while (i < SS_TIMEOUT && (v & SS_DATA_END));
477d9b2e591b8d drivers/crypto/sunxi-ss/sun4i-ss-hash.c           Corentin LABBE 2016-08-10  365  	if (unlikely(i >= SS_TIMEOUT)) {
6298e948215f2a drivers/crypto/sunxi-ss/sun4i-ss-hash.c           LABBE Corentin 2015-07-17  366  		dev_err_ratelimited(ss->dev,
6298e948215f2a drivers/crypto/sunxi-ss/sun4i-ss-hash.c           LABBE Corentin 2015-07-17  367  				    "ERROR: hash end timeout %d>%d ctl=%x len=%u\n",
6298e948215f2a drivers/crypto/sunxi-ss/sun4i-ss-hash.c           LABBE Corentin 2015-07-17  368  				    i, SS_TIMEOUT, v, areq->nbytes);
6298e948215f2a drivers/crypto/sunxi-ss/sun4i-ss-hash.c           LABBE Corentin 2015-07-17  369  		err = -EIO;
6298e948215f2a drivers/crypto/sunxi-ss/sun4i-ss-hash.c           LABBE Corentin 2015-07-17  370  		goto release_ss;
6298e948215f2a drivers/crypto/sunxi-ss/sun4i-ss-hash.c           LABBE Corentin 2015-07-17  371  	}
6298e948215f2a drivers/crypto/sunxi-ss/sun4i-ss-hash.c           LABBE Corentin 2015-07-17  372  
049655499e2ecc drivers/crypto/sunxi-ss/sun4i-ss-hash.c           Antoine Tenart 2017-06-01  373  	/*
049655499e2ecc drivers/crypto/sunxi-ss/sun4i-ss-hash.c           Antoine Tenart 2017-06-01  374  	 * The datasheet isn't very clear about when to retrieve the digest. The
049655499e2ecc drivers/crypto/sunxi-ss/sun4i-ss-hash.c           Antoine Tenart 2017-06-01  375  	 * bit SS_DATA_END is cleared when the engine has processed the data and
049655499e2ecc drivers/crypto/sunxi-ss/sun4i-ss-hash.c           Antoine Tenart 2017-06-01  376  	 * when the digest is computed *but* it doesn't mean the digest is
049655499e2ecc drivers/crypto/sunxi-ss/sun4i-ss-hash.c           Antoine Tenart 2017-06-01  377  	 * available in the digest registers. Hence the delay to be sure we can
049655499e2ecc drivers/crypto/sunxi-ss/sun4i-ss-hash.c           Antoine Tenart 2017-06-01  378  	 * read it.
049655499e2ecc drivers/crypto/sunxi-ss/sun4i-ss-hash.c           Antoine Tenart 2017-06-01  379  	 */
049655499e2ecc drivers/crypto/sunxi-ss/sun4i-ss-hash.c           Antoine Tenart 2017-06-01  380  	ndelay(1);
049655499e2ecc drivers/crypto/sunxi-ss/sun4i-ss-hash.c           Antoine Tenart 2017-06-01  381  
6298e948215f2a drivers/crypto/sunxi-ss/sun4i-ss-hash.c           LABBE Corentin 2015-07-17  382  	for (i = 0; i < crypto_ahash_digestsize(tfm) / 4; i++)
6298e948215f2a drivers/crypto/sunxi-ss/sun4i-ss-hash.c           LABBE Corentin 2015-07-17  383  		op->hash[i] = readl(ss->base + SS_MD0 + i * 4);
6298e948215f2a drivers/crypto/sunxi-ss/sun4i-ss-hash.c           LABBE Corentin 2015-07-17  384  
477d9b2e591b8d drivers/crypto/sunxi-ss/sun4i-ss-hash.c           Corentin LABBE 2016-08-10  385  	goto release_ss;
6298e948215f2a drivers/crypto/sunxi-ss/sun4i-ss-hash.c           LABBE Corentin 2015-07-17  386  
6298e948215f2a drivers/crypto/sunxi-ss/sun4i-ss-hash.c           LABBE Corentin 2015-07-17  387  /*
477d9b2e591b8d drivers/crypto/sunxi-ss/sun4i-ss-hash.c           Corentin LABBE 2016-08-10  388   * hash_final: finalize hashing operation
6298e948215f2a drivers/crypto/sunxi-ss/sun4i-ss-hash.c           LABBE Corentin 2015-07-17  389   *
6298e948215f2a drivers/crypto/sunxi-ss/sun4i-ss-hash.c           LABBE Corentin 2015-07-17  390   * If we have some remaining bytes, we write them.
6298e948215f2a drivers/crypto/sunxi-ss/sun4i-ss-hash.c           LABBE Corentin 2015-07-17  391   * Then ask the SS for finalizing the hashing operation
6298e948215f2a drivers/crypto/sunxi-ss/sun4i-ss-hash.c           LABBE Corentin 2015-07-17  392   *
6298e948215f2a drivers/crypto/sunxi-ss/sun4i-ss-hash.c           LABBE Corentin 2015-07-17  393   * I do not check RX FIFO size in this function since the size is 32
6298e948215f2a drivers/crypto/sunxi-ss/sun4i-ss-hash.c           LABBE Corentin 2015-07-17  394   * after each enabling and this function neither write more than 32 words.
477d9b2e591b8d drivers/crypto/sunxi-ss/sun4i-ss-hash.c           Corentin LABBE 2016-08-10  395   * If we come from the update part, we cannot have more than
933e7e3ab239fe drivers/crypto/sunxi-ss/sun4i-ss-hash.c           Corentin LABBE 2016-08-10  396   * 3 remaining bytes to write and SS is fast enough to not care about it.
6298e948215f2a drivers/crypto/sunxi-ss/sun4i-ss-hash.c           LABBE Corentin 2015-07-17  397   */
6298e948215f2a drivers/crypto/sunxi-ss/sun4i-ss-hash.c           LABBE Corentin 2015-07-17  398  
477d9b2e591b8d drivers/crypto/sunxi-ss/sun4i-ss-hash.c           Corentin LABBE 2016-08-10  399  hash_final:
6298e948215f2a drivers/crypto/sunxi-ss/sun4i-ss-hash.c           LABBE Corentin 2015-07-17  400  
6298e948215f2a drivers/crypto/sunxi-ss/sun4i-ss-hash.c           LABBE Corentin 2015-07-17  401  	/* write the remaining words of the wait buffer */
a595e60a70c0d0 drivers/crypto/sunxi-ss/sun4i-ss-hash.c           Antoine Tenart 2017-06-01  402  	if (op->len) {
6298e948215f2a drivers/crypto/sunxi-ss/sun4i-ss-hash.c           LABBE Corentin 2015-07-17  403  		nwait = op->len / 4;
a595e60a70c0d0 drivers/crypto/sunxi-ss/sun4i-ss-hash.c           Antoine Tenart 2017-06-01  404  		if (nwait) {
6298e948215f2a drivers/crypto/sunxi-ss/sun4i-ss-hash.c           LABBE Corentin 2015-07-17  405  			writesl(ss->base + SS_RXFIFO, op->buf, nwait);
6298e948215f2a drivers/crypto/sunxi-ss/sun4i-ss-hash.c           LABBE Corentin 2015-07-17  406  			op->byte_count += 4 * nwait;
6298e948215f2a drivers/crypto/sunxi-ss/sun4i-ss-hash.c           LABBE Corentin 2015-07-17  407  		}
d78867a94ea74b drivers/crypto/sunxi-ss/sun4i-ss-hash.c           Antoine Tenart 2017-06-01  408  
6298e948215f2a drivers/crypto/sunxi-ss/sun4i-ss-hash.c           LABBE Corentin 2015-07-17  409  		nbw = op->len - 4 * nwait;
d78867a94ea74b drivers/crypto/sunxi-ss/sun4i-ss-hash.c           Antoine Tenart 2017-06-01  410  		if (nbw) {
d1d787bcebfe12 drivers/crypto/allwinner/sun4i-ss/sun4i-ss-hash.c Corentin Labbe 2019-11-14  411  			wb = cpu_to_le32(*(u32 *)(op->buf + nwait * 4));
d78867a94ea74b drivers/crypto/sunxi-ss/sun4i-ss-hash.c           Antoine Tenart 2017-06-01 @412  			wb &= GENMASK((nbw * 8) - 1, 0);
214a9bd0f8dec4 drivers/crypto/sunxi-ss/sun4i-ss-hash.c           Antoine Tenart 2017-06-01  413  
214a9bd0f8dec4 drivers/crypto/sunxi-ss/sun4i-ss-hash.c           Antoine Tenart 2017-06-01  414  			op->byte_count += nbw;
6298e948215f2a drivers/crypto/sunxi-ss/sun4i-ss-hash.c           LABBE Corentin 2015-07-17  415  		}
d78867a94ea74b drivers/crypto/sunxi-ss/sun4i-ss-hash.c           Antoine Tenart 2017-06-01  416  	}
6298e948215f2a drivers/crypto/sunxi-ss/sun4i-ss-hash.c           LABBE Corentin 2015-07-17  417  
6298e948215f2a drivers/crypto/sunxi-ss/sun4i-ss-hash.c           LABBE Corentin 2015-07-17  418  	/* write the remaining bytes of the nbw buffer */
6298e948215f2a drivers/crypto/sunxi-ss/sun4i-ss-hash.c           LABBE Corentin 2015-07-17 @419  	wb |= ((1 << 7) << (nbw * 8));
d1d787bcebfe12 drivers/crypto/allwinner/sun4i-ss/sun4i-ss-hash.c Corentin Labbe 2019-11-14  420  	bf[j++] = le32_to_cpu(wb);
6298e948215f2a drivers/crypto/sunxi-ss/sun4i-ss-hash.c           LABBE Corentin 2015-07-17  421  
6298e948215f2a drivers/crypto/sunxi-ss/sun4i-ss-hash.c           LABBE Corentin 2015-07-17  422  	/*
6298e948215f2a drivers/crypto/sunxi-ss/sun4i-ss-hash.c           LABBE Corentin 2015-07-17  423  	 * number of space to pad to obtain 64o minus 8(size) minus 4 (final 1)
6298e948215f2a drivers/crypto/sunxi-ss/sun4i-ss-hash.c           LABBE Corentin 2015-07-17  424  	 * I take the operations from other MD5/SHA1 implementations
6298e948215f2a drivers/crypto/sunxi-ss/sun4i-ss-hash.c           LABBE Corentin 2015-07-17  425  	 */
6298e948215f2a drivers/crypto/sunxi-ss/sun4i-ss-hash.c           LABBE Corentin 2015-07-17  426  
214a9bd0f8dec4 drivers/crypto/sunxi-ss/sun4i-ss-hash.c           Antoine Tenart 2017-06-01  427  	/* last block size */
214a9bd0f8dec4 drivers/crypto/sunxi-ss/sun4i-ss-hash.c           Antoine Tenart 2017-06-01  428  	fill = 64 - (op->byte_count % 64);
214a9bd0f8dec4 drivers/crypto/sunxi-ss/sun4i-ss-hash.c           Antoine Tenart 2017-06-01  429  	min_fill = 2 * sizeof(u32) + (nbw ? 0 : sizeof(u32));
214a9bd0f8dec4 drivers/crypto/sunxi-ss/sun4i-ss-hash.c           Antoine Tenart 2017-06-01  430  
214a9bd0f8dec4 drivers/crypto/sunxi-ss/sun4i-ss-hash.c           Antoine Tenart 2017-06-01  431  	/* if we can't fill all data, jump to the next 64 block */
214a9bd0f8dec4 drivers/crypto/sunxi-ss/sun4i-ss-hash.c           Antoine Tenart 2017-06-01  432  	if (fill < min_fill)
214a9bd0f8dec4 drivers/crypto/sunxi-ss/sun4i-ss-hash.c           Antoine Tenart 2017-06-01  433  		fill += 64;
6298e948215f2a drivers/crypto/sunxi-ss/sun4i-ss-hash.c           LABBE Corentin 2015-07-17  434  
214a9bd0f8dec4 drivers/crypto/sunxi-ss/sun4i-ss-hash.c           Antoine Tenart 2017-06-01  435  	j += (fill - min_fill) / sizeof(u32);
6298e948215f2a drivers/crypto/sunxi-ss/sun4i-ss-hash.c           LABBE Corentin 2015-07-17  436  
6298e948215f2a drivers/crypto/sunxi-ss/sun4i-ss-hash.c           LABBE Corentin 2015-07-17  437  	/* write the length of data */
6298e948215f2a drivers/crypto/sunxi-ss/sun4i-ss-hash.c           LABBE Corentin 2015-07-17  438  	if (op->mode == SS_OP_SHA1) {
d1d787bcebfe12 drivers/crypto/allwinner/sun4i-ss/sun4i-ss-hash.c Corentin Labbe 2019-11-14  439  		__be64 *bits = (__be64 *)&bf[j];
d1d787bcebfe12 drivers/crypto/allwinner/sun4i-ss/sun4i-ss-hash.c Corentin Labbe 2019-11-14  440  		*bits = cpu_to_be64(op->byte_count << 3);
d1d787bcebfe12 drivers/crypto/allwinner/sun4i-ss/sun4i-ss-hash.c Corentin Labbe 2019-11-14  441  		j += 2;
6298e948215f2a drivers/crypto/sunxi-ss/sun4i-ss-hash.c           LABBE Corentin 2015-07-17  442  	} else {
d1d787bcebfe12 drivers/crypto/allwinner/sun4i-ss/sun4i-ss-hash.c Corentin Labbe 2019-11-14  443  		__le64 *bits = (__le64 *)&bf[j];
d1d787bcebfe12 drivers/crypto/allwinner/sun4i-ss/sun4i-ss-hash.c Corentin Labbe 2019-11-14  444  		*bits = cpu_to_le64(op->byte_count << 3);
d1d787bcebfe12 drivers/crypto/allwinner/sun4i-ss/sun4i-ss-hash.c Corentin Labbe 2019-11-14  445  		j += 2;
6298e948215f2a drivers/crypto/sunxi-ss/sun4i-ss-hash.c           LABBE Corentin 2015-07-17  446  	}
6298e948215f2a drivers/crypto/sunxi-ss/sun4i-ss-hash.c           LABBE Corentin 2015-07-17  447  	writesl(ss->base + SS_RXFIFO, bf, j);
6298e948215f2a drivers/crypto/sunxi-ss/sun4i-ss-hash.c           LABBE Corentin 2015-07-17  448  
6298e948215f2a drivers/crypto/sunxi-ss/sun4i-ss-hash.c           LABBE Corentin 2015-07-17  449  	/* Tell the SS to stop the hashing */
6298e948215f2a drivers/crypto/sunxi-ss/sun4i-ss-hash.c           LABBE Corentin 2015-07-17  450  	writel(op->mode | SS_ENABLED | SS_DATA_END, ss->base + SS_CTL);
6298e948215f2a drivers/crypto/sunxi-ss/sun4i-ss-hash.c           LABBE Corentin 2015-07-17  451  
6298e948215f2a drivers/crypto/sunxi-ss/sun4i-ss-hash.c           LABBE Corentin 2015-07-17  452  	/*
6298e948215f2a drivers/crypto/sunxi-ss/sun4i-ss-hash.c           LABBE Corentin 2015-07-17  453  	 * Wait for SS to finish the hash.
933e7e3ab239fe drivers/crypto/sunxi-ss/sun4i-ss-hash.c           Corentin LABBE 2016-08-10  454  	 * The timeout could happen only in case of bad overclocking
6298e948215f2a drivers/crypto/sunxi-ss/sun4i-ss-hash.c           LABBE Corentin 2015-07-17  455  	 * or driver bug.
6298e948215f2a drivers/crypto/sunxi-ss/sun4i-ss-hash.c           LABBE Corentin 2015-07-17  456  	 */
6298e948215f2a drivers/crypto/sunxi-ss/sun4i-ss-hash.c           LABBE Corentin 2015-07-17  457  	i = 0;
6298e948215f2a drivers/crypto/sunxi-ss/sun4i-ss-hash.c           LABBE Corentin 2015-07-17  458  	do {
6298e948215f2a drivers/crypto/sunxi-ss/sun4i-ss-hash.c           LABBE Corentin 2015-07-17  459  		v = readl(ss->base + SS_CTL);
6298e948215f2a drivers/crypto/sunxi-ss/sun4i-ss-hash.c           LABBE Corentin 2015-07-17  460  		i++;
a595e60a70c0d0 drivers/crypto/sunxi-ss/sun4i-ss-hash.c           Antoine Tenart 2017-06-01  461  	} while (i < SS_TIMEOUT && (v & SS_DATA_END));
477d9b2e591b8d drivers/crypto/sunxi-ss/sun4i-ss-hash.c           Corentin LABBE 2016-08-10  462  	if (unlikely(i >= SS_TIMEOUT)) {
6298e948215f2a drivers/crypto/sunxi-ss/sun4i-ss-hash.c           LABBE Corentin 2015-07-17  463  		dev_err_ratelimited(ss->dev,
6298e948215f2a drivers/crypto/sunxi-ss/sun4i-ss-hash.c           LABBE Corentin 2015-07-17  464  				    "ERROR: hash end timeout %d>%d ctl=%x len=%u\n",
6298e948215f2a drivers/crypto/sunxi-ss/sun4i-ss-hash.c           LABBE Corentin 2015-07-17  465  				    i, SS_TIMEOUT, v, areq->nbytes);
6298e948215f2a drivers/crypto/sunxi-ss/sun4i-ss-hash.c           LABBE Corentin 2015-07-17  466  		err = -EIO;
6298e948215f2a drivers/crypto/sunxi-ss/sun4i-ss-hash.c           LABBE Corentin 2015-07-17  467  		goto release_ss;
6298e948215f2a drivers/crypto/sunxi-ss/sun4i-ss-hash.c           LABBE Corentin 2015-07-17  468  	}
6298e948215f2a drivers/crypto/sunxi-ss/sun4i-ss-hash.c           LABBE Corentin 2015-07-17  469  
049655499e2ecc drivers/crypto/sunxi-ss/sun4i-ss-hash.c           Antoine Tenart 2017-06-01  470  	/*
049655499e2ecc drivers/crypto/sunxi-ss/sun4i-ss-hash.c           Antoine Tenart 2017-06-01  471  	 * The datasheet isn't very clear about when to retrieve the digest. The
049655499e2ecc drivers/crypto/sunxi-ss/sun4i-ss-hash.c           Antoine Tenart 2017-06-01  472  	 * bit SS_DATA_END is cleared when the engine has processed the data and
049655499e2ecc drivers/crypto/sunxi-ss/sun4i-ss-hash.c           Antoine Tenart 2017-06-01  473  	 * when the digest is computed *but* it doesn't mean the digest is
049655499e2ecc drivers/crypto/sunxi-ss/sun4i-ss-hash.c           Antoine Tenart 2017-06-01  474  	 * available in the digest registers. Hence the delay to be sure we can
049655499e2ecc drivers/crypto/sunxi-ss/sun4i-ss-hash.c           Antoine Tenart 2017-06-01  475  	 * read it.
049655499e2ecc drivers/crypto/sunxi-ss/sun4i-ss-hash.c           Antoine Tenart 2017-06-01  476  	 */
049655499e2ecc drivers/crypto/sunxi-ss/sun4i-ss-hash.c           Antoine Tenart 2017-06-01  477  	ndelay(1);
049655499e2ecc drivers/crypto/sunxi-ss/sun4i-ss-hash.c           Antoine Tenart 2017-06-01  478  
6298e948215f2a drivers/crypto/sunxi-ss/sun4i-ss-hash.c           LABBE Corentin 2015-07-17  479  	/* Get the hash from the device */
6298e948215f2a drivers/crypto/sunxi-ss/sun4i-ss-hash.c           LABBE Corentin 2015-07-17  480  	if (op->mode == SS_OP_SHA1) {
6298e948215f2a drivers/crypto/sunxi-ss/sun4i-ss-hash.c           LABBE Corentin 2015-07-17  481  		for (i = 0; i < 5; i++) {
6298e948215f2a drivers/crypto/sunxi-ss/sun4i-ss-hash.c           LABBE Corentin 2015-07-17  482  			v = cpu_to_be32(readl(ss->base + SS_MD0 + i * 4));
6298e948215f2a drivers/crypto/sunxi-ss/sun4i-ss-hash.c           LABBE Corentin 2015-07-17  483  			memcpy(areq->result + i * 4, &v, 4);
6298e948215f2a drivers/crypto/sunxi-ss/sun4i-ss-hash.c           LABBE Corentin 2015-07-17  484  		}
6298e948215f2a drivers/crypto/sunxi-ss/sun4i-ss-hash.c           LABBE Corentin 2015-07-17  485  	} else {
6298e948215f2a drivers/crypto/sunxi-ss/sun4i-ss-hash.c           LABBE Corentin 2015-07-17  486  		for (i = 0; i < 4; i++) {
d1d787bcebfe12 drivers/crypto/allwinner/sun4i-ss/sun4i-ss-hash.c Corentin Labbe 2019-11-14 @487  			v = cpu_to_le32(readl(ss->base + SS_MD0 + i * 4));
6298e948215f2a drivers/crypto/sunxi-ss/sun4i-ss-hash.c           LABBE Corentin 2015-07-17  488  			memcpy(areq->result + i * 4, &v, 4);
6298e948215f2a drivers/crypto/sunxi-ss/sun4i-ss-hash.c           LABBE Corentin 2015-07-17  489  		}
6298e948215f2a drivers/crypto/sunxi-ss/sun4i-ss-hash.c           LABBE Corentin 2015-07-17  490  	}
6298e948215f2a drivers/crypto/sunxi-ss/sun4i-ss-hash.c           LABBE Corentin 2015-07-17  491  
6298e948215f2a drivers/crypto/sunxi-ss/sun4i-ss-hash.c           LABBE Corentin 2015-07-17  492  release_ss:
6298e948215f2a drivers/crypto/sunxi-ss/sun4i-ss-hash.c           LABBE Corentin 2015-07-17  493  	writel(0, ss->base + SS_CTL);
6298e948215f2a drivers/crypto/sunxi-ss/sun4i-ss-hash.c           LABBE Corentin 2015-07-17  494  	spin_unlock_bh(&ss->slock);
6298e948215f2a drivers/crypto/sunxi-ss/sun4i-ss-hash.c           LABBE Corentin 2015-07-17  495  	return err;
6298e948215f2a drivers/crypto/sunxi-ss/sun4i-ss-hash.c           LABBE Corentin 2015-07-17  496  }
6298e948215f2a drivers/crypto/sunxi-ss/sun4i-ss-hash.c           LABBE Corentin 2015-07-17  497  

:::::: The code at line 412 was first introduced by commit
:::::: d78867a94ea74b8d2dafdbf370e0707f37a58f4a crypto: sun4i-ss - use GENMASK to generate masks

:::::: TO: Antoine Ténart <antoine.tenart@free-electrons.com>
:::::: CC: Herbert Xu <herbert@gondor.apana.org.au>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

--9amGYk9869ThD9tj
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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

--9amGYk9869ThD9tj--
